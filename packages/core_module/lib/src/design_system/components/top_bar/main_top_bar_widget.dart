import 'package:flutter/material.dart';
import '../../../../core_module.dart';

class MainTopBarWidget extends StatefulWidget {
  const MainTopBarWidget({
    super.key, this.authKey,
  });
  final Key? authKey;
  @override
  State<MainTopBarWidget> createState() => _MainTopBarWidgetState();
}

class _MainTopBarWidgetState extends State<MainTopBarWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
  @override
  void didUpdateWidget(covariant MainTopBarWidget oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 28, left: 16, right: 18, bottom: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
              LogoIconWidget(),
              AuthCircleAvatarWidget(key: widget.authKey,)
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
