import 'dart:io';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';

class NextButtonWidget extends StatelessWidget {
  const NextButtonWidget(
      {Key? key,
      this.width,
      required this.route,
      required this.arguments,
      required this.color,
      required this.size})
      : super(key: key);
  final String route;
  final double size;
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
                CupertinoIcons.chevron_forward,
              ),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  route,
                  arguments: arguments,
                );
              },
            ),
          )
        : IconButton(
            iconSize: 39,
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
