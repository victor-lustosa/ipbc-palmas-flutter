import 'dart:io';

import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';

class CupertinoSliverWidget extends StatelessWidget {
  const CupertinoSliverWidget({
    super.key,
    this.radius,
    this.color,
    this.size,
    required this.action,
  });
  final double? radius;
  final double? size;
  final Color? color;
  final Future<void> Function() action;

  @override
  Widget build(context) {
    return Platform.isIOS ?
        CupertinoSliverRefreshControl(
        onRefresh: action,
        builder: (_, _, pulledExtent, _, _) {
          return Center(
            child: Opacity(
              opacity: (pulledExtent / 100.0).clamp(0.0, 1.0),
              child: CupertinoActivityIndicator(
                color:color ?? AppColors.darkGreen,
                radius: radius ?? 14,
              ),
            ),
          );
        },
      ) : SizedBox();
  }
}
