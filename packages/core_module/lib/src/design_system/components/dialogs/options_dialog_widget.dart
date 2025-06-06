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
    barrierDismissible: false,
    barrierColor: AppColors.black.withValues(alpha: .3),
    builder: (BuildContext context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            width: context.sizeOf.width,
            child: Dialog(
              insetPadding: EdgeInsets.zero,
              surfaceTintColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: AppColors.searchBar,
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    margin: EdgeInsets.only(bottom: context.sizeOf.height * .3),
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                            bottom: 18,
                            left: 20,
                            top: 18,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                Modular.get<EditLiturgyViewModel>()
                                    .entity
                                    .sequence,
                                style: AppFonts.defaultFont(
                                  color: AppColors.grey9,
                                  fontSize: 17,
                                ),
                              ),
                              Visibility(
                                visible:
                                    Modular.get<EditLiturgyViewModel>()
                                        .entity
                                        .isAdditional,
                                child: Container(
                                  margin: const EdgeInsets.only(top: 4),
                                  child: Text(
                                    Modular.get<EditLiturgyViewModel>()
                                        .entity
                                        .isAdditional ? Modular.get<EditLiturgyViewModel>()
                                        .entity
                                        .additional! : '',
                                    style: AppFonts.defaultFont(
                                      color: AppColors.grey8,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: .8),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            actionButton(
                              context: context,
                              callback: callback,
                              top: 20,
                              bottom: 12,
                              icon: AppIcons.addNotes,
                              label: 'Add Box',
                              action: () {
                                Modular.get<EditLiturgyViewModel>().addBox();
                                closeDialog(
                                  context: context,
                                  callback: callback,
                                );
                              },
                            ),
                            const Divider(
                              height: 1,
                              color: AppColors.cardBallsGrey,
                            ),
                            actionButton(
                              context: context,
                              callback: callback,
                              top: 12,
                              bottom: 12,
                              icon: AppIcons.contentCopy,
                              label: 'Duplicar',
                              action: () {
                                Modular.get<EditLiturgyViewModel>()
                                    .copyEntity();
                                closeDialog(
                                  context: context,
                                  callback: callback,
                                );
                              },
                            ),
                            const Divider(
                              height: 1,
                              color: AppColors.cardBallsGrey,
                            ),
                            actionButton(
                              context: context,
                              callback: callback,
                              top: 12,
                              bottom: 20,
                              icon: AppIcons.trash,
                              label: 'Deletar',
                              action: () {
                                Modular.get<EditLiturgyViewModel>().delete();
                                closeDialog(
                                  context: context,
                                  callback: callback,
                                );
                              },
                            ),
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
                          width: context.sizeOf.width,
                          child: ButtonWidget(
                            overlayColor: Colors.transparent,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            adaptiveButtonType: AdaptiveButtonType.text,
                            action: () {
                              closeDialog(context: context, callback: callback);
                            },
                            backgroundColor: Colors.white.withValues(
                              alpha: .8,
                            ),
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

closeDialog({required BuildContext context, final Function(bool?)? callback}) {
  if (callback != null) {
    callback(false);
  }
  pop(context);
}

actionButton({
  required BuildContext context,
  final Function(bool?)? callback,
  required String icon,
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
          margin: EdgeInsets.only(right: 10, left: context.sizeOf.width * .31),
          height: 20,
          width: 20,
          child: Image.asset(icon),
        ),
        Text(
          label,
          style: AppFonts.defaultFont(fontSize: 17, color: AppColors.grey10),
        ),
      ],
    ),
  );
}
