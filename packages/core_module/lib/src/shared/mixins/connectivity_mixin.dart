import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../../../core_module.dart';

mixin ConnectivityMixin {
  Future<bool> isConnected({
    required BuildContext context,
    Function()? onDelayedAction,
    Alignment? alignment,
    Duration? duration,
    double? width,
  }) async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult.contains(ConnectivityResult.none)) {
        if (context.mounted) {
          showCustomMessageDialog(
            width: width,
            alignment: alignment,
            context: context,
            duration: duration,
            title: 'Sem conexão',
            message: 'Verifique sua conexão com a internet e tente novamente.',
            type: DialogType.warning,
            onDelayedAction: onDelayedAction,
          );
        }
        return false;
      } else {
        return true;
      }
    } on PlatformException catch (e, st) {
      AnalyticsUtil.recordError(error: e, st: st, name: 'lyric view model');
      if (context.mounted) {
        showCustomMessageDialog(
          context: context,
          title: 'Erro ao verificar conexão',
          message: 'Verifique sua conexão com a internet e tente novamente.',
          type: DialogType.warning,
          onDelayedAction: onDelayedAction,
        );
      }
      return false;
    }
  }
}
