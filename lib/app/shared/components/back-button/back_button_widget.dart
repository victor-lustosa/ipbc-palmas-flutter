import 'package:flutter/material.dart';

import '../../configs/app_configs.dart';
class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      highlightColor: AppColors.white,
      splashColor: AppColors.white,
      hoverColor: AppColors.white,
      onPressed: () {},
      icon: const Icon(
        size: 34,
        Icons.arrow_back_rounded,
        color: AppColors.darkGreen,
      ),
    );
  }
}
