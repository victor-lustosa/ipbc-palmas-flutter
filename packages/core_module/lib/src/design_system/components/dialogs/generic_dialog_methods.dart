import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

closeDialog({required BuildContext context, final Function(bool?)? callback}) {
    if (callback != null) {
      callback(false);
    }
    pop(context);
}
