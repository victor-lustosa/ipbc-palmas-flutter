import 'dart:ui';

import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

Future<void> showConfirmationDialog({
  required BuildContext context,
  required String title,
  required String message,
  Widget? buttons,
  VoidCallback? confirmAction,
}) async {
  await showGeneralDialog(
    context: context,
    barrierDismissible: false,
    barrierLabel: 'Modal de confirmação de exclusão',
    barrierColor: AppColors.grey6.withValues(alpha: .3),
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (buildContext, animation, secondaryAnimation) {
      return ConfirmDialogWidget(
        buttons: buttons,
        message: message,
        title: title,
        confirmAction: confirmAction,
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

class ConfirmDialogWidget extends StatefulWidget {
  const ConfirmDialogWidget({
    super.key,
     this.buttons,
    required this.message,
    required this.title,
    this.confirmAction
  });

  final Widget? buttons;
  final String message;
  final String title;
  final VoidCallback? confirmAction;


  @override
  State<ConfirmDialogWidget> createState() => _ConfirmDialogWidgetState();
}

class _ConfirmDialogWidgetState extends State<ConfirmDialogWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.sizeOf.width,
      height: context.sizeOf.height,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 32),
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            insetPadding: EdgeInsets.zero,
            backgroundColor: AppColors.white,
            child: AspectRatio(
              aspectRatio: 304 / 170,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.dividerModal.withValues(alpha: .1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 24),
                      child: Text(
                        widget.title,
                        style: AppFonts.defaultFont(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: AppColors.grey10,
                        ),
                      ),
                    ),
                    Container(
                      width: context.sizeOf.width * .6,
                      margin: EdgeInsets.only(bottom: 10),
                      child: Text(
                        widget.message,
                        textAlign: TextAlign.center,
                        style: AppFonts.defaultFont(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: AppColors.grey10,
                        ),
                      ),
                    ),

                    Column(
                      children: [
                        Divider(
                          height: 1,
                          color: AppColors.dividerModal.withValues(alpha: .3),
                        ),
                        SizedBox(
                          height: 48,
                          child: widget.buttons?? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ButtonWidget(
                                padding: EdgeInsets.zero,
                                adaptiveButtonType: AdaptiveButtonType.text,
                                action: () => nativePop(context),
                                child: Text(
                                  'Cancelar',
                                  style: AppFonts.defaultFont(
                                    color: AppColors.grey10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              VerticalDivider(
                                width: 2,
                                thickness: 1,
                                color: AppColors.dividerModal.withValues(alpha: .3),
                              ),
                              ButtonWidget(
                                padding: EdgeInsets.zero,
                                adaptiveButtonType: AdaptiveButtonType.text,
                                action: widget.confirmAction,
                                child: const Text(
                                  'Deletar',
                                  style: TextStyle(
                                    color: AppColors.cancelDeleteModal,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ) ,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


