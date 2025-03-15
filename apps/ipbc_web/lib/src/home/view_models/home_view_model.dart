import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class HomeViewModel with EmailMixin {
  ScrollController scrollController = ScrollController();

  sendBySendGrid() {
    /* sendGrid(
          body: '${nameController.text} /n ${messageController.text}',
          subject: 'victor.olustosa@outlook.com',
          recipients: [emailController.text],
     );*/
  }

  sendByBrevo() {
    /* brevo(
          body: '${nameController.text} /n ${messageController.text}',
          subject: 'victor.olustosa@outlook.com',
          recipients: [emailController.text],
     );*/
  }
}
