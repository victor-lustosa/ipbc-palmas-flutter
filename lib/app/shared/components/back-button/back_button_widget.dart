import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ipbc_palmas/app/shared/configs/app_routes.dart';
import '../../configs/app_configs.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget(
      {Key? key,
      required this.size,
      this.width,
      required this.router,
      required this.color,
      this.arguments})
      : super(key: key);
  final double size;
  final String router;
  final double? width;
  final Color? color;
  final dynamic arguments;
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Container(
            width: width,
            //decoration: BoxDecoration(border: Border.all(color: Colors.red)),
            child: CupertinoButton(
              padding: const EdgeInsets.only(bottom: 0),
              child: Icon(
                size: size,
                color: color,
                CupertinoIcons.chevron_back,
              ),
              onPressed: () => Navigator.pop(
                context,
              ),
            ),
          )
        : IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () => Navigator.pop(
              context,
            ),
            icon: Icon(
              size: size,
              Icons.arrow_back_rounded,
              color: AppColors.darkGreen,
            ),
          );
  }
}
