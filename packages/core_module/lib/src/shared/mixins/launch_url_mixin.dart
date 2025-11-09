import 'package:flutter/material.dart';
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
        alignment: Alignment.bottomRight,
        width: 350,
        title: 'Erro ao redirecionar',
        message: 'Verifique sua conexão com a internet e tente novamente.',
        type: DialogType.error,
        duration: Duration(seconds: 6)
      );
    }
  }
}
