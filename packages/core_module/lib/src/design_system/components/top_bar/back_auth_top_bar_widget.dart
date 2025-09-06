import 'package:flutter/material.dart';
import '../../../../core_module.dart';

class BackAuthTopBarWidget extends StatefulWidget {
  const BackAuthTopBarWidget({
    super.key,
    this.margin,
    this.action,
    this.isHome,
  });

  final EdgeInsetsGeometry? margin;
  final void Function()? action;
  final bool? isHome;

  @override
  State<BackAuthTopBarWidget> createState() => _BackAuthTopBarWidgetState();
}

class _BackAuthTopBarWidgetState extends State<BackAuthTopBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin:
              widget.margin ??
              const EdgeInsets.only(top: 22, left: 16, right: 16, bottom: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              (widget.isHome ?? false)
                  ? LogoIconWidget()
                  : BackButtonWidget(action: widget.action),
              AuthCircleAvatarWidget(),
            ],
          ),
        ),
      ],
    );
  }
}
