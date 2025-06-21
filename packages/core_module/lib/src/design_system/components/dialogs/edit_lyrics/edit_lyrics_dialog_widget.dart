import 'dart:async';
import 'dart:ui';

import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> showEditLyricsDialog({
  required BuildContext context,
  required LyricEntity entity,
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
                filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                child: Container(
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColors.dividerModal.withValues(alpha: 25),
                      width: 1,
                    ),
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
                    backgroundColor: Colors.black.withAlpha(3),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            pushNamed(
                              AppRoutes.servicesRoute +
                                  AppRoutes.editLyricRoute,
                              arguments: entity,
                            );
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                  bottom: 10,
                                  top: 21,
                                  left: 13,
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(right: 10),
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
                              SizedBox(
                                height: 40,
                                width: 40,
                                child: IconButtonWidget(
                                  size: 20,
                                  action: () {
                                    callback(false);
                                    Modular.to.pop(context);
                                  },
                                  color: AppColors.grey10,
                                  iOSIcon: CupertinoIcons.clear,
                                  androidIcon: Icons.clear,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                          color: AppColors.dividerModal.withValues(alpha: 25),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 12, left: 12),
                          child: Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 10),
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
