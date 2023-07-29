import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../components/emails/models/send_grid_model.dart';

mixin EmailMixin {
  static const _apiSendGridURL = "https://api.sendgrid.com/v3/mail/send";
  static const _apiBrevoURL = "https://api.sendgrid.com/v3/mail/send";

  static const String _sendGridKEY = "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";
  static const String _brevoKEY = "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";

  Future<String> sendGrid(
      {required String body,
      required String subject,
      required List<String> recipients}) async {
    final fromAddress = Address(recipients[0]);
    final content = Content('text/plain', body);
    const personalization = Personalization([Address('victor.olustosa@outlook.com')]);

    final email = Email([personalization], fromAddress, subject, content: [content]);
    final v = jsonEncode(email.toJson());
    print(v);
    try {
      http.post(
        Uri.parse(_apiSendGridURL),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: _sendGridKEY
        },
        body: v,
      );
      return '';
    } catch (error) {
      //analyticsUtil.recordError(name: 'service util', error: error, st: st);
      return error.toString();
    }
  }

  Future<String> brevo(
      {required String body,
        required String subject,
        required List<String> recipients}) async {
    final fromAddress = Address(recipients[0]);
    final content = Content('text/plain', body);
    const personalization =  Personalization([Address('victor.olustosa@outlook.com')]);

    final email = Email([personalization], fromAddress, subject, content: [content]);
    final v = jsonEncode(email.toJson());
    print(v);
    try {
      http.post(
        Uri.parse(_apiBrevoURL),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: _brevoKEY
        },
        body: v,
      );
      return '';
    } catch (error) {
      //analyticsUtil.recordError(name: 'service util', error: error, st: st);
      return error.toString();
    }
  }
}
