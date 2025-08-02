import 'dart:async';
import 'dart:ui';

import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

Future<void> showEditDialog({
  required BuildContext context,
  required GlobalKey itemKey,
  Widget? itemContent,
  required Widget buttons,
  double? popupHeightParam,
  double? verticalMarginParam,
}) async {
  final RenderBox renderBox =
      itemKey.currentContext!.findRenderObject() as RenderBox;
  final itemOffset = renderBox.localToGlobal(Offset.zero);
  final itemSize = renderBox.size;

  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;

  const double popupWidth = 180.0;
  double popupHeight = popupHeightParam ?? 160.0;
  const screenEdgeMargin = 16.0;

  final double popupLeft = screenWidth - popupWidth - screenEdgeMargin;

  double verticalMargin = verticalMarginParam ?? 8.0;

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
      return EditDialogWidget(
        popupTop: popupTop,
        itemContent: itemContent,
        buttons: buttons,
        popupLeft: popupLeft,
        itemOffset: itemOffset,
        itemSize: itemSize,
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

class EditDialogWidget extends StatefulWidget {
  const EditDialogWidget({
    super.key,
    required this.itemSize,
    this.itemContent,
    required this.buttons,
    required this.popupLeft,
    required this.itemOffset,
    required this.popupTop,
  });

  final Offset itemOffset;
  final Size itemSize;
  final Widget? itemContent;
  final Widget buttons;
  final double popupLeft;
  final double popupTop;

  @override
  State<EditDialogWidget> createState() => _EditDialogWidgetState();
}

class _EditDialogWidgetState extends State<EditDialogWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IgnorePointer(
          ignoring: true,
          child: Stack(
            children: [
              Visibility(
                visible: widget.itemContent != null,
                child: Positioned(
                  top: widget.itemOffset.dy,
                  left: widget.itemOffset.dx,
                  child: SizedBox(
                    width: widget.itemSize.width,
                    height: widget.itemSize.height,
                    child: Transform.scale(
                      scale: 1.1,
                      child: Material(
                        color: Colors.transparent,
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 12),
                          child: widget.itemContent,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: widget.popupTop,
          left: widget.popupLeft,
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
              child: Container(
                  width: 180,
                  decoration: BoxDecoration(
                    color: AppColors.dividerModal.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: widget.buttons
              ),
            ),
          ),
        ),
      ],
    );
  }
}
