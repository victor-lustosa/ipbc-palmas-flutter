import 'package:flutter/material.dart';
import 'package:core_module/core_module.dart';

class LogoIconWidget extends StatelessWidget {
  const LogoIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IconWidget(
      size:Size(78, 32),
      iconFormat: IconFormat.svg,
      iconName:  AppIcons.logo,
    );
  }
}
