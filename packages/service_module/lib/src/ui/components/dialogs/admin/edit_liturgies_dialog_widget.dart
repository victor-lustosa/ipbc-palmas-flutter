import 'dart:async';
import 'dart:ui';

import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

Future<void> showEditDialog({
  required BuildContext context,
  required GlobalKey itemKey,
  required Widget itemContent,
  required Widget buttons
}) async {
  final RenderBox renderBox =
      itemKey.currentContext!.findRenderObject() as RenderBox;
  final itemOffset = renderBox.localToGlobal(Offset.zero);
  final itemSize = renderBox.size;

  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;

  const popupWidth = 180.0;
  const popupHeight = 160.0;
  const screenEdgeMargin = 16.0;

  final double popupLeft = screenWidth - popupWidth - screenEdgeMargin;

  const double verticalMargin = 8.0;
  double popupTop;

  final desiredTop = itemOffset.dy + itemSize.height + verticalMargin;

  if (desiredTop + popupHeight > screenHeight - screenEdgeMargin) {
    popupTop = itemOffset.dy - popupHeight - verticalMargin;
  } else {
    popupTop = desiredTop;
  }

  if (popupTop < screenEdgeMargin) {
    popupTop = screenEdgeMargin;
  }

  await showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Opções',
    barrierColor: Colors.transparent,
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (buildContext, animation, secondaryAnimation) {
      return Stack(
        children: [
          IgnorePointer(
            ignoring: true,
            child: Stack(
              children: [
                Positioned(
                  top: itemOffset.dy,
                  left: itemOffset.dx,
                  child: SizedBox(
                    width: itemSize.width,
                    height: itemSize.height,
                    child: Transform.scale(
                      scale: 1.1,
                      child: Material(
                        color: Colors.transparent,
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 12),
                          child: itemContent,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: popupTop,
            left: popupLeft,
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
                child: Container(
                  width: 180,
                  decoration: BoxDecoration(
                    color: AppColors.dividerModal.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: buttons
                  ),
                ),
              ),
            ),
        ],
      );
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
        reverseCurve: Curves.easeOutCubic,
      );
      return FadeTransition(
        opacity: curved,
        child: child,
      );
    },
  );
}
