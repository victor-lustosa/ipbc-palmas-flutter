import 'dart:io';

import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class BackButtonWidget extends StatelessWidget {
  final String route;

  const BackButtonWidget({
    Key? key,
    required this.route,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButtonWidget(
      size: Platform.isIOS ? null : 28,
      color: AppColors.darkGreen,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      iOSIcon: CupertinoIcons.chevron_back,
      androidIcon: Icons.arrow_back_rounded,
      action: () => Modular.to.navigate(route),
    );
  }
}
