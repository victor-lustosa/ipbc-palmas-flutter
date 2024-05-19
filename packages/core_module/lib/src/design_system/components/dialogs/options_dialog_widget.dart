import 'dart:async';
import 'dart:ui';

import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

Future<void> showCustomOptionsDialog({
  required BuildContext context,
  final Function(bool?)? callback,
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    barrierColor: AppColors.black.withOpacity(0.3),
    builder: (BuildContext context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            width: context.mediaQuery.size.width,
            child: Dialog(
              insetPadding: EdgeInsets.zero,
              surfaceTintColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              child: Column(
                children: [
                  ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            button(context: context,callback: callback, top: 20,bottom: 12,icon: AppIcons.addNotes, label:  'Add Box'),
                            const Divider(
                              height: 1,
                              color: AppColors.cardBallsGrey,
                            ),
                            button(context: context,callback: callback, top: 12,bottom: 12,icon: AppIcons.contentCopy, label:  'Duplicar'),
                            const Divider(
                              height: 1,
                              color: AppColors.cardBallsGrey,
                            ),
                            button(context: context,callback: callback, top: 12,bottom: 20,icon: AppIcons.trash, label:  'Deletar'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 16),
                    child: ClipRRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                        child: SizedBox(
                          width: context.mediaQuery.size.width,
                          child: ButtonWidget(
                            overlayColor: Colors.transparent,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            adaptiveButtonType: AdaptiveButtonType.text,
                            action: () {
                              if (callback != null) {
                                callback(false);
                              }
                              pop(context);
                            },
                            backgroundColor: Colors.white.withOpacity(0.8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              'Cancelar',
                              style: AppFonts.defaultFont(
                                fontSize: 17,
                                color: AppColors.grey10,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    },
  );
}

button({
  required BuildContext context,
  final Function(bool?)? callback,
  required String icon,
  required String label,
  required double top,
  required double bottom
}) {
  return ButtonWidget(
    overlayColor: Colors.transparent,
    padding: EdgeInsets.only(
      top: top,
      bottom: bottom,
    ),
    adaptiveButtonType: AdaptiveButtonType.text,
    action: () {
      if (callback != null) {
        callback(false);
      }
      pop(context);
    },
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(
            right: 10,
            left: context.mediaQuery.size.width * .31,
          ),
          height: 20,
          width: 20,
          child: Image.asset(icon),
        ),
        Text(
          label,
          style: AppFonts.defaultFont(
            fontSize: 17,
            color: AppColors.grey10,
          ),
        ),
      ],
    ),
  );
}
