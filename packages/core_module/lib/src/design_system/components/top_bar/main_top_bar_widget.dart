import 'package:flutter/material.dart';
import '../../../../core_module.dart';

class MainTopBarWidget extends StatefulWidget {
  const MainTopBarWidget({super.key, this.margin, this.items});

  final EdgeInsetsGeometry? margin;
  final Widget? items;

  @override
  State<MainTopBarWidget> createState() => _MainTopBarWidgetState();
}

class _MainTopBarWidgetState extends State<MainTopBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          widget.margin ??
          const EdgeInsets.only(top: 22, left: 16, right: 18, bottom: 24),
      child: widget.items ?? Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          LogoIconWidget(),
          AuthCircleAvatarWidget(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
