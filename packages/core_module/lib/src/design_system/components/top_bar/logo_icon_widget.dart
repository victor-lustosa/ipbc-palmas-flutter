import 'package:flutter/material.dart';
import 'package:core_module/core_module.dart';

class LogoIconWidget extends StatelessWidget {
  const LogoIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 78,
      height: 32,
      child: SvgPicture.asset(
        AppIcons.logo,
        colorFilter: const ColorFilter.mode(
          AppColors.darkGreen,
          BlendMode.srcIn,
        ),
        //  height: 75,width: 75,
      ),
    );
  }
}
