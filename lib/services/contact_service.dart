import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/emailjs_config.dart';

/// Exception thrown when contact message submission fails.
class ContactServiceException implements Exception {
  final String message;
  final int? statusCode;

  ContactServiceException(this.message, {this.statusCode});

  @override
  String toString() => message;
}

/// Service class for submitting portfolio contact messages using EmailJS REST API.
class ContactService {
  final http.Client _client;
  final String _serviceId;
  final String _templateId;
  final String _publicKey;
  final String _endpoint;

  ContactService({
    http.Client? client,
    String? serviceId,
    String? templateId,
    String? publicKey,
    String? endpoint,
  })  : _client = client ?? http.Client(),
        _serviceId = serviceId ?? EmailJSConfig.serviceId,
        _templateId = templateId ?? EmailJSConfig.templateId,
        _publicKey = publicKey ?? EmailJSConfig.publicKey,
        _endpoint = endpoint ?? EmailJSConfig.endpoint;

  /// Sends a contact message to EmailJS via REST API endpoint.
  ///
  /// Parameters sent in `template_params`:
  /// - `name`: Sender's name
  /// - `email`: Sender's email
  /// - `subject`: Message subject
  /// - `message`: Message content
  Future<void> submitContactMessage({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) async {
    final trimmedName = name.trim();
    final trimmedEmail = email.trim();
    final trimmedSubject = subject.trim();
    final trimmedMessage = message.trim();

    // Input Validation
    if (trimmedName.isEmpty) {
      throw ContactServiceException('Please enter your name.');
    }
    if (trimmedEmail.isEmpty) {
      throw ContactServiceException('Please enter your email.');
    }
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(trimmedEmail)) {
      throw ContactServiceException('Please enter a valid email address.');
    }
    if (trimmedSubject.isEmpty) {
      throw ContactServiceException('Please enter a subject.');
    }
    if (trimmedMessage.isEmpty) {
      throw ContactServiceException('Please enter a message.');
    }

    // Configuration Verification
    if (_serviceId == 'YOUR_SERVICE_ID' || _serviceId.trim().isEmpty) {
      throw ContactServiceException(
        'EmailJS Service ID is not configured. Please set your Service ID in lib/utils/emailjs_config.dart.',
      );
    }
    if (_publicKey == 'YOUR_PUBLIC_KEY' || _publicKey.trim().isEmpty) {
      throw ContactServiceException(
        'EmailJS Public Key is not configured. Please set your Public Key in lib/utils/emailjs_config.dart.',
      );
    }

    // Prepare EmailJS REST API Payload
    final payload = {
      'service_id': _serviceId,
      'template_id': _templateId,
      'user_id': _publicKey,
      'template_params': {
        'name': trimmedName,
        'email': trimmedEmail,
        'subject': trimmedSubject,
        'message': trimmedMessage,
      },
    };

    try {
      final response = await _client.post(
        Uri.parse(_endpoint),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(payload),
      );

      if (response.statusCode == 200) {
        return;
      } else {
        final bodyText = response.body.trim();
        final errorDetail =
            bodyText.isNotEmpty ? bodyText : 'HTTP ${response.statusCode}';
        throw ContactServiceException(
          'EmailJS request failed: $errorDetail',
          statusCode: response.statusCode,
        );
      }
    } on ContactServiceException {
      rethrow;
    } catch (e) {
      throw ContactServiceException(
        'Unable to send email: ${e.toString()}',
      );
    }
  }
}
