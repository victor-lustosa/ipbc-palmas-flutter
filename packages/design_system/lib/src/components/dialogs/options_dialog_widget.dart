import 'dart:async';
import 'dart:ui';

import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> showCustomOptionsDialog({
  required BuildContext context,
  required final Function(bool) callback,
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.transparent,
    builder: (BuildContext context) {
      return Stack(
        children: [
          Align(
            alignment: const Alignment(1, .8),
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                        color: AppColors.dividerModal.withOpacity(0.1),
                        width: 1),
                  ),
                  height: 108,
                  width: 170,
                  child: AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    insetPadding: EdgeInsets.zero,
                    contentPadding: EdgeInsets.zero,
                    surfaceTintColor: Colors.transparent,
                    backgroundColor: Colors.transparent.withOpacity(0.01),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                bottom: 12,
                                top: 20,
                                left: 13,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                      right: 10,
                                    ),
                                    child: SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: Image.asset(AppIcons.edit),
                                    ),
                                  ),
                                  Text(
                                    'Editar',
                                    style: AppFonts.defaultFont(
                                      fontSize: 17,
                                      color: AppColors.grey10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButtonWidget(
                                sizeIcon: 20,
                                size: 40,
                                action: () {
                                  callback(false);
                                 pop(context);
                                },
                                color: AppColors.grey10,
                                iOSIcon: CupertinoIcons.clear,
                                androidIcon: Icons.clear,
                            ),
                          ],
                        ),
                        Divider(
                          height: 1,
                          color: AppColors.dividerModal.withOpacity(0.1),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                            top: 12,
                            left: 12,
                          ),
                          child: Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                  right: 10,
                                ),
                                height: 20,
                                width: 20,
                                child: Image.asset(AppIcons.trash),
                              ),
                              Text(
                                'Deletar',
                                style: AppFonts.defaultFont(
                                  fontSize: 17,
                                  color: AppColors.grey10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}
