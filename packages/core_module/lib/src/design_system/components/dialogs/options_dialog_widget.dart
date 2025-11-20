import 'dart:async';
import 'dart:ui';

import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

Future<void> showOptionsDialog({
  required BuildContext context,
  required GlobalKey itemKey,
  Widget? itemContent,
  required Widget buttons,
  double? popupHeightParam,
  double? verticalMarginParam,
  double? popupWidthParam,
  double? popupWidthPositionParam,
  double? screenEdgeMarginParam,
  bool? isBackgroundSolid,
}) async {
  final RenderBox renderBox =
      itemKey.currentContext!.findRenderObject() as RenderBox;
  final itemOffset = renderBox.localToGlobal(Offset.zero);
  final itemSize = renderBox.size;

  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;

  double popupWidthPosition = popupWidthPositionParam ?? 170.0;
  double popupHeight = popupHeightParam ?? 160.0;
  double screenEdgeMargin = screenEdgeMarginParam ?? 16.0;

  final double popupLeft = screenWidth - popupWidthPosition - screenEdgeMargin;

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
      return OptionsDialogWidget(
        popupTop: popupTop,
        itemContent: itemContent,
        buttons: buttons,
        popupLeft: popupLeft,
        itemOffset: itemOffset,
        itemSize: itemSize,
        popupWidth: popupWidthParam,
        isBackgroundSolid: isBackgroundSolid ?? false,
      );
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.95, end: 1.0).animate(animation),
          child: child,
        ),
      );
    },
  );
}

class OptionsDialogWidget extends StatefulWidget {
  const OptionsDialogWidget({
    super.key,
    required this.itemSize,
    this.itemContent,
    required this.buttons,
    required this.popupLeft,
    required this.itemOffset,
    required this.popupTop,
    this.popupWidth,
    required this.isBackgroundSolid,
  });

  final Offset itemOffset;
  final Size itemSize;
  final Widget? itemContent;
  final Widget buttons;
  final double popupLeft;
  final double? popupWidth;
  final double popupTop;
  final bool isBackgroundSolid;

  @override
  State<OptionsDialogWidget> createState() => _OptionsDialogWidgetState();
}

class _OptionsDialogWidgetState extends State<OptionsDialogWidget> {
  @override
  Widget build(BuildContext context) {
    Widget dialog = Container(
      width: widget.popupWidth ?? 170,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.dividerModal.withValues(alpha: .1)),
        color: widget.isBackgroundSolid
            ? AppColors.white
            : AppColors.dividerModal.withValues(alpha: .1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: widget.buttons,
    );
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
            child: widget.isBackgroundSolid
                ? dialog
                : BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
                    child: dialog,
                  ),
          ),
        ),
      ],
    );
  }
}

ButtonWidget actionButton({
  required BuildContext context,
  final Function(bool?)? callback,
  required String icon,
  double? fontSize,
  required String label,
  required double top,
  required double bottom,
  required VoidCallback? action,
}) {
  return ButtonWidget(
    overlayColor: Colors.transparent,
    padding: EdgeInsets.only(top: top, bottom: bottom),
    adaptiveButtonType: AdaptiveButtonType.text,
    action: action,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(right: 10, left: 13),
          height: 20,
          child: Image.asset(icon),
        ),
        Text(
          label,
          style: AppFonts.defaultFont(
            fontSize: fontSize ?? 17,
            color: AppColors.grey10,
          ),
        ),
      ],
    ),
  );
}
