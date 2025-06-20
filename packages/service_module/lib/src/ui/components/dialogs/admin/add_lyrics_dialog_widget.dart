import 'dart:async';
import 'dart:ui';

import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';


Future<void> showAddLyricsDialog({
  required BuildContext context,
  Function(bool?)? callback,
}) {
  return showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierColor: Colors.black.withAlpha(100),
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) {
      return SafeArea(
        child: Builder(
          builder: (context) => Center(
            child: AddLyricsDialogWidget(callback: callback),
          ),
        ),
      );
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
        reverseCurve: Curves.easeInCubic,
      );
      return FadeTransition(
        opacity: curved,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.1),
            end: Offset.zero,
          ).animate(curved),
          child: child,
        ),
      );
    },
  );
}

class AddLyricsDialogWidget extends StatelessWidget {
  const AddLyricsDialogWidget({super.key, required this.callback});
  final Function(bool?)? callback;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
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
                  margin: EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          bottom: 18,
                          left: 20,
                          top: 18,
                        ),

                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}


