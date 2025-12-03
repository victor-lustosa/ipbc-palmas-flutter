import 'package:flutter/material.dart';

import '../../../../core_module.dart';

class CustomReloadScrollWidget extends StatelessWidget {
  const CustomReloadScrollWidget({
    super.key,
    required this.action,
    required this.child,
  });

  final Future<void> Function() action;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicatorWidget(
      action: action,
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: [
          CupertinoSliverWidget(action: action),
          SliverToBoxAdapter(child: child),
        ],
      ),
    );
  }
}
