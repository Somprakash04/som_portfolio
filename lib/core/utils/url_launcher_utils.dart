import 'package:url_launcher/url_launcher.dart';

/// ─────────────────────────────────────────────────────────────
/// UrlLauncherUtils — thin wrapper around url_launcher.
/// ─────────────────────────────────────────────────────────────
abstract class UrlLauncherUtils {
  /// Opens [url] in an external browser / app.
  static Future<void> open(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  /// Composes an email using the mailto scheme.
  static Future<void> sendEmail(
    String email, {
    String subject = '',
    String body = '',
  }) async {
    final mailUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        if (subject.isNotEmpty) 'subject': subject,
        if (body.isNotEmpty) 'body': body,
      },
    );
    await launchUrl(mailUri);
  }

  /// Triggers a file download (web-compatible via URL).
  static Future<void> download(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}
