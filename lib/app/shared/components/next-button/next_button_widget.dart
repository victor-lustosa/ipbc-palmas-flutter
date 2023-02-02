import 'dart:io';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';

class NextButtonWidget extends StatelessWidget {
  const NextButtonWidget(
      {Key? key,
      required this.route,
      required this.arguments,
      required this.color,
      required this.size})
      : super(key: key);
  final String route;
  final double size;
  final Color? color;
  final dynamic arguments;
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            padding: const EdgeInsets.only(bottom: 0, right: 2),
            child: Icon(
              size: size,
              color: color,
              CupertinoIcons.chevron_forward,
            ),
            onPressed: () {
              Navigator.pushNamed(
                context,
                route,
                arguments: arguments,
              );
            },
          )
        : IconButton(
            padding: const EdgeInsets.only(bottom: 0, left: 5),
            iconSize: size,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () {
              Navigator.pushNamed(
                context,
                route,
                arguments: arguments,
              );
            },
            icon: Icon(
              Icons.navigate_next_sharp,
              color: color,
            ),
          );
  }
}
