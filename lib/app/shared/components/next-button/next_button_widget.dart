import 'package:flutter/material.dart';
import '../../configs/app_configs.dart';

class NextButtonWidget extends StatelessWidget {
  const NextButtonWidget({Key? key, required this.route, this.arguments}) : super(key: key);
  final String route;
  final Color? color;
  final dynamic arguments;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pushNamed(
          context,route,
          arguments: arguments,
        );
      },
      icon: const Icon(
        size: 39,
        Icons.navigate_next_sharp,
        color: color,
      ),
    );
  }
}
