import 'package:flutter/material.dart';
import '../../../../core_module.dart';

class BackAuthTopBarWidget extends StatefulWidget {
  const BackAuthTopBarWidget({super.key, this.margin, required this.action});

  final EdgeInsetsGeometry? margin;
  final void Function() action;

  @override
  State<BackAuthTopBarWidget> createState() => _BackAuthTopBarWidgetState();
}

class _BackAuthTopBarWidgetState extends State<BackAuthTopBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          widget.margin ??
          const EdgeInsets.only(top: 22, left: 16, right: 18, bottom: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BackButtonWidget(action: widget.action),
          AuthCircleAvatarWidget(
            key: Modular.get<AppGlobalKeys>().authAvatarKey,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
