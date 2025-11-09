import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core_module.dart';

mixin LaunchUrlMixin {
  Future<void> launchInBrowser(
    Uri url,
    BuildContext context, {
    LaunchMode? launchMode,
        double? width,
        Alignment? alignment,
  }) async {
    if (!await launchUrl(
      url,
      mode: launchMode ?? LaunchMode.externalApplication,
    )) {
      if (context.mounted) {
        showCustomMessageDialog(
            context: context,
            alignment: alignment,
            width: width,
            title: 'Erro ao redirecionar',
            message: 'Verifique sua conexão com a internet e tente novamente.',
            type: DialogType.error,
        );
      }
    }
  }
}
