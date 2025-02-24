import 'package:flutter/material.dart';

import '../../../../core_module.dart';
import '../auth/logo_icon_widget.dart';

class MainTopBarWidget extends StatefulWidget {
  const MainTopBarWidget({
    super.key,
    this.margin,
    this.topBarList,
    this.authAvatarKey,
    this.mainAxisAlignment,
  });

  final EdgeInsetsGeometry? margin;
  final List<Widget>? topBarList;
  final Key? authAvatarKey;
  final MainAxisAlignment? mainAxisAlignment;

  @override
  State<MainTopBarWidget> createState() => _MainTopBarWidgetState();
}

class _MainTopBarWidgetState extends State<MainTopBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          widget.margin ??
          const EdgeInsets.only(top: 28, left: 16, right: 18, bottom: 24),
      child: Row(
        mainAxisAlignment:
            widget.mainAxisAlignment ?? MainAxisAlignment.spaceBetween,
        children:
            widget.topBarList ??
            [
              LogoIconWidget(),
              AuthCircleAvatarWidget(key: widget.authAvatarKey),
            ],
      ),
    );
  }
}
