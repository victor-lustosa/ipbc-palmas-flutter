import 'package:flutter/material.dart';

import '../../../../../core_module.dart';

class MainTopBarWidget extends StatelessWidget {
  const MainTopBarWidget(
      {super.key,
      this.margin,
      this.topBarList,
      this.mainAxisAlignment});

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
                top: 22,
                left: 16,
                right: 18,
                bottom: 24,
              ),
          child: Row(
            mainAxisAlignment:
                mainAxisAlignment ?? MainAxisAlignment.spaceBetween,
            children: topBarList ?? [
              LogoIconWidget(),
              AuthCircleAvatarWidget(
                picture: "https://firebasestorage.googleapis.com/v0/b/ipbc-palmas-9d93d.appspot.com/o/profile.jpeg?alt=media&token=1e1415e3-4137-4a78-ba74-8b408784aeaa",
              )],
          ),
        );
      },
    );
  }
}
