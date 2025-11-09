import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core_module.dart';

mixin LaunchUrlMixin {
  Future<void> launchInBrowser(
    Uri url,
    BuildContext context, [
    LaunchMode? launchMode,
  ]) async {

    if (context.mounted) {
      showCustomMessageDialog(
        context: context,
        title: 'Erro ao abrir link',
        message: 'Verifique sua conexão com a internet e tente novamente.',
        type: DialogType.error,
      );
    }
  }
}
