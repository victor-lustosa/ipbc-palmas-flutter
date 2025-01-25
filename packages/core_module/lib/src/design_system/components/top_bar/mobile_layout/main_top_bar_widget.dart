import 'package:flutter/material.dart';

import '../../../../../core_module.dart';

class MainTopBarWidget extends StatelessWidget {
  const MainTopBarWidget(
      {super.key, this.margin, this.topBarList, this.mainAxisAlignment});

  final EdgeInsetsGeometry? margin;
  final List<Widget>? topBarList;
  final MainAxisAlignment? mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Container(
          margin: margin ??
              const EdgeInsets.only(
                top: 28,
                left: 16,
                right: 18,
                bottom: 24,
              ),
          child: Row(
            mainAxisAlignment:
                mainAxisAlignment ?? MainAxisAlignment.spaceBetween,
            children: topBarList ??
                [
                  LogoIconWidget(),
                  AuthCircleAvatarWidget(),
                ],
          ),
        );
      },
    );
  }
}
