import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:mariyaportfoliyo/services/contact_service.dart';

void main() {
  group('ContactService EmailJS Integration Tests', () {
    test('submitContactMessage sends correct payload to EmailJS REST API', () async {
      late Uri capturedUri;
      late Map<String, String> capturedHeaders;
      late Map<String, dynamic> capturedBody;

      final mockClient = MockClient((request) async {
        capturedUri = request.url;
        capturedHeaders = request.headers;
        capturedBody = jsonDecode(request.body) as Map<String, dynamic>;
        return http.Response('OK', 200);
      });

      final service = ContactService(
        client: mockClient,
        serviceId: 'service_test123',
        templateId: 'template_3xah8tb',
        publicKey: 'public_key_abc',
        endpoint: 'https://api.emailjs.com/api/v1.0/email/send',
      );

      await service.submitContactMessage(
        name: 'John Doe',
        email: 'john@example.com',
        subject: 'Project Inquiry',
        message: 'Hello, I would like to discuss a project.',
      );

      expect(capturedUri.toString(), equals('https://api.emailjs.com/api/v1.0/email/send'));
      expect(capturedHeaders['Content-Type'], contains('application/json'));
      expect(capturedBody['service_id'], equals('service_test123'));
      expect(capturedBody['template_id'], equals('template_3xah8tb'));
      expect(capturedBody['user_id'], equals('public_key_abc'));

      final params = capturedBody['template_params'] as Map<String, dynamic>;
      expect(params['name'], equals('John Doe'));
      expect(params['email'], equals('john@example.com'));
      expect(params['subject'], equals('Project Inquiry'));
      expect(params['message'], equals('Hello, I would like to discuss a project.'));
    });

    test('submitContactMessage throws validation exception for empty email', () async {
      final service = ContactService(
        serviceId: 'service_test123',
        publicKey: 'public_key_abc',
      );

      expect(
        () => service.submitContactMessage(
          name: 'John',
          email: '',
          subject: 'Hi',
          message: 'Hello',
        ),
        throwsA(isA<ContactServiceException>().having(
          (e) => e.message,
          'message',
          contains('Please enter your email'),
        )),
      );
    });

    test('submitContactMessage throws validation exception for invalid email format', () async {
      final service = ContactService(
        serviceId: 'service_test123',
        publicKey: 'public_key_abc',
      );

      expect(
        () => service.submitContactMessage(
          name: 'John',
          email: 'not-an-email',
          subject: 'Hi',
          message: 'Hello',
        ),
        throwsA(isA<ContactServiceException>().having(
          (e) => e.message,
          'message',
          contains('valid email address'),
        )),
      );
    });

    test('submitContactMessage throws exception when server returns non-200', () async {
      final mockClient = MockClient((request) async {
        return http.Response('The user_id parameter is required', 400);
      });

      final service = ContactService(
        client: mockClient,
        serviceId: 'service_test123',
        templateId: 'template_3xah8tb',
        publicKey: 'invalid_key',
      );

      expect(
        () => service.submitContactMessage(
          name: 'John',
          email: 'john@example.com',
          subject: 'Test Subject',
          message: 'Test Message',
        ),
        throwsA(isA<ContactServiceException>().having(
          (e) => e.message,
          'message',
          contains('The user_id parameter is required'),
        )),
      );
    });
  });
}
