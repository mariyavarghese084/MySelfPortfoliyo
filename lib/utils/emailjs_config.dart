/// Configuration settings for EmailJS REST API integration.
///
/// IMPORTANT SECURITY WARNING:
/// - Only the EmailJS Public Key (user_id) should be placed here or passed in.
/// - NEVER include an EmailJS Private Key (accessToken), Gmail password, or secret key.
class EmailJSConfig {
  /// EmailJS REST API v1.0 send endpoint
  static const String endpoint = 'https://api.emailjs.com/api/v1.0/email/send';

  /// EmailJS Service ID (e.g., 'service_xxxxx')
  /// Can be overridden at build time via: --dart-define EMAILJS_SERVICE_ID=your_service_id
  static const String serviceId = String.fromEnvironment(
    'EMAILJS_SERVICE_ID',
    defaultValue: 'service_ts8j7wm', // Replace with your EmailJS Service ID
  );

  /// EmailJS Template ID
  /// Can be overridden at build time via: --dart-define EMAILJS_TEMPLATE_ID=your_template_id
  static const String templateId = String.fromEnvironment(
    'EMAILJS_TEMPLATE_ID',
    defaultValue: 'template_3xah8tb',
  );

  /// EmailJS Public Key (user_id)
  /// Can be overridden at build time via: --dart-define EMAILJS_PUBLIC_KEY=your_public_key
  static const String publicKey = String.fromEnvironment(
    'EMAILJS_PUBLIC_KEY',
    defaultValue: 'M05BBtKd4rfk_ewsD', // Replace with your EmailJS Public Key
  );
}
