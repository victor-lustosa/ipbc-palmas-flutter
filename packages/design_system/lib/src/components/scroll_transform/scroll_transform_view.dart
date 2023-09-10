/*
import 'package:flutter/material.dart';

import '../../../design_system.dart';

class ScrollTransformView extends StatefulWidget {
  final ScrollController controller;
  final List<ScrollTransformItem> children;
  const ScrollTransformView({
    Key? key,
    required this.children, required this.controller,
  }) : super(key: key);

  @override
  State<ScrollTransformView> createState() => _ScrollTransformViewState();
}

class _ScrollTransformViewState extends State<ScrollTransformView> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: widget.controller,
      child: ChangeNotifierProvider(
        create: (context) => widget.controller,
        child: Column(
          children: widget.children,
        ),
      ),
    );
  }
}*/