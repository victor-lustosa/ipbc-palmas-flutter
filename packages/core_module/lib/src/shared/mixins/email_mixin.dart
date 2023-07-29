import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../components/emails/models/keys_api_emails.dart';
import '../components/emails/models/send_grid_model.dart';

mixin EmailMixin {
  static const _apiSendGridURL = "https://api.sendgrid.com/v3/mail/send";
  static const _apiBrevoURL = "https://api.sendgrid.com/v3/mail/send";

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
          HttpHeaders.authorizationHeader: KeysApiEmails.sendGridKEY
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
          HttpHeaders.authorizationHeader: KeysApiEmails.brevoKEY
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
