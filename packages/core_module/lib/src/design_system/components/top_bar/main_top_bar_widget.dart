import 'package:flutter/material.dart';
import '../../../../core_module.dart';

class MainTopBarWidget extends StatefulWidget {
  const MainTopBarWidget({
    super.key,
  });

  @override
  State<MainTopBarWidget> createState() => _MainTopBarWidgetState();
}

class _MainTopBarWidgetState extends State<MainTopBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 28, left: 16, right: 18, bottom: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
              LogoIconWidget(),
              AuthCircleAvatarWidget(key: Modular.get<AppGlobalKeys>().authAvatarKey)
            ],
      ),
    );
  }
}
