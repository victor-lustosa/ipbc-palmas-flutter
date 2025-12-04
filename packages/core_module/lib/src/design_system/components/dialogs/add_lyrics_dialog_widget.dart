import 'dart:async';
import 'dart:ui';

import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

Future<void> showAddLyricsDialog({
  required BuildContext context,
  Function(Map<String, String>?)? callback,
}) {
  return showGeneralDialog(
    context: context,
    barrierDismissible: false,
    barrierLabel: "Adicionar letra",
    barrierColor: AppColors.grey6.withValues(alpha: .3),
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) {
      return SafeArea(
        bottom: false,
        child: Builder(
          builder: (context) =>
              Center(child: AddLyricsDialogWidget(callback: callback)),
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
        opacity: animation,
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

class AddLyricsDialogWidget extends StatefulWidget {
  const AddLyricsDialogWidget({super.key, required this.callback});

  final Function(Map<String, String>?)? callback;

  @override
  State<AddLyricsDialogWidget> createState() => _AddLyricsDialogWidgetState();
}

class _AddLyricsDialogWidgetState extends State<AddLyricsDialogWidget> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _artistController = TextEditingController();
  final TextEditingController _lyricsController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _artistController.dispose();
    _lyricsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        hideKeyboard(context);
        FocusScope.of(context).unfocus();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            width: context.sizeOf.width,
            constraints: BoxConstraints(maxHeight: context.sizeOf.height * .9),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: Dialog(
                insetPadding: EdgeInsets.zero,
                surfaceTintColor: AppColors.grey9,
                backgroundColor: AppColors.grey9,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Insira a letra:',
                        style: AppFonts.defaultFont(
                          fontWeight: FontWeight.w500,
                          fontSize: 22,
                          color: AppColors.grey10,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Flexible(
                        child: Material(
                          color: Colors.transparent,
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              textSelectionTheme: TextSelectionThemeData(
                                cursorColor: AppColors.grey7,
                                selectionColor: AppColors.grey7.withValues(
                                  alpha: .30,
                                ),
                                selectionHandleColor: AppColors.grey7,
                              ),
                              colorScheme: Theme.of(
                                context,
                              ).colorScheme.copyWith(primary: AppColors.grey7),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: AppColors.grey3),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                  ),
                                  margin: EdgeInsets.only(bottom: 10),
                                  child: TextFormField(
                                    selectionControls:
                                        MaterialTextSelectionControls(),
                                    controller: _titleController,
                                    minLines: 1,
                                    maxLines: 2,
                                    keyboardType: TextInputType.multiline,
                                    decoration: InputDecoration(
                                      hintText: 'Digite o título',
                                      hintStyle: AppFonts.defaultFont(
                                        color: AppColors.grey5,
                                        fontSize: 16,
                                      ),
                                      fillColor: AppColors.white,
                                      border: InputBorder.none,
                                      contentPadding: const EdgeInsets.all(12),
                                    ),
                                    style: AppFonts.defaultFont(
                                      color: AppColors.grey10,
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: AppColors.grey3),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                  ),
                                  margin: EdgeInsets.only(bottom: 10),
                                  child: TextFormField(
                                    selectionControls:
                                        MaterialTextSelectionControls(),
                                    controller: _artistController,
                                    minLines: 1,
                                    maxLines: 2,
                                    keyboardType: TextInputType.multiline,
                                    decoration: InputDecoration(
                                      hintText: 'Digite o Artista',
                                      hintStyle: AppFonts.defaultFont(
                                        color: AppColors.grey5,
                                        fontSize: 16,
                                      ),
                                      fillColor: AppColors.white,
                                      border: InputBorder.none,
                                      contentPadding: const EdgeInsets.all(12),
                                    ),
                                    style: AppFonts.defaultFont(
                                      color: AppColors.grey10,
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: AppColors.grey3),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8),
                                      ),
                                    ),
                                    child: TextFormField(
                                      selectionControls:
                                          MaterialTextSelectionControls(),
                                      controller: _lyricsController,
                                      minLines: null,
                                      maxLines: null,
                                      expands: true,
                                      keyboardType: TextInputType.multiline,
                                      decoration: InputDecoration(
                                        hintText:
                                            'Cole ou digite a letra aqui...',
                                        hintStyle: AppFonts.defaultFont(
                                          color: AppColors.grey5,
                                          fontSize: 16,
                                        ),
                                        fillColor: AppColors.white,
                                        border: InputBorder.none,
                                        contentPadding: const EdgeInsets.all(
                                          12,
                                        ),
                                      ),
                                      style: AppFonts.defaultFont(
                                        color: AppColors.grey10,
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ButtonWidget(
                              adaptiveButtonType: AdaptiveButtonType.text,
                              action: () {
                                Navigator.of(context).pop();
                              },
                              fixedSize: const Size(132, 28),
                              overlayColor: Colors.white,
                              backgroundColor: AppColors.white,
                              foregroundColor: AppColors.darkGreen,
                              foregroundHoveredColor: AppColors.darkGreen,
                              child: Text("Cancelar"),
                            ),
                            const SizedBox(width: 8),
                            ButtonWidget(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              fixedSize: const Size(132, 28),
                              action: () {
                                if (widget.callback != null) {
                                  widget.callback!({
                                    'lyrics': _lyricsController.text.trim(),
                                    'title': _titleController.text.trim(),
                                    'artist': _artistController.text.trim(),
                                  });
                                }
                              },
                              backgroundColor: AppColors.darkGreen,
                              shadowColor: AppColors.grey0,
                              foregroundColor: AppColors.white,
                              child: Text("Adicionar"),
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
        ],
      ),
    );
  }
}
