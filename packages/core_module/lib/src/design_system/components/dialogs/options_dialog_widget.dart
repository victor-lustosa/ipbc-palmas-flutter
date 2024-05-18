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
    barrierColor: AppColors.black.withOpacity(0.15),
    builder: (BuildContext context) {
      return Stack(
        children: [
          Align(
            child: ClipRRect(
              child: Container(
                height: 108,
                width: MediaQuery.of(context).size.width * .8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                      color: AppColors.dividerModal.withOpacity(0.1), width: 1),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                  child: AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    insetPadding: EdgeInsets.zero,
                    contentPadding: EdgeInsets.zero,
                    surfaceTintColor: Colors.transparent,
                    backgroundColor: Colors.white.withOpacity(0.7),
                    content: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
