import 'package:flutter/material.dart';

class NextButtonWidget extends StatelessWidget {
  const NextButtonWidget(
      {Key? key, required this.route, this.arguments, this.color})
      : super(key: key);
  final String route;
  final Color? color;
  final dynamic arguments;
  @override
  Widget build(BuildContext context) {
    return IconButton(
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
