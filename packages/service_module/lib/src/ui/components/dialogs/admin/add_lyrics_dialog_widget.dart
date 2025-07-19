import 'dart:async';
import 'dart:ui';
import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

Future<void> showAddLyricsDialog({
  required BuildContext context,
  Function(String?)? callback,
}) {
  return showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Adicionar letra",
    barrierColor: Colors.transparent,
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) {
      return SafeArea(
        child: Builder(
          builder:
              (context) =>
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

class AddLyricsDialogWidget extends StatefulWidget {
  const AddLyricsDialogWidget({super.key, required this.callback});

  final Function(String?)? callback;

  @override
  State<AddLyricsDialogWidget> createState() => _AddLyricsDialogWidgetState();
}

class _AddLyricsDialogWidgetState extends State<AddLyricsDialogWidget> {
  final TextEditingController _lyricsController = TextEditingController();

  @override
  void dispose() {
    _lyricsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          width: context.sizeOf.width,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: ClipRRect(
              child: Dialog(
                insetPadding: EdgeInsets.zero,
                surfaceTintColor: Colors.transparent,
                backgroundColor: Colors.transparent,
                child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: AppColors.secondaryGrey2,
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Insira a letra:',
                            style: AppFonts.defaultFont(
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                              color: AppColors.grey10,
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _lyricsController,
                            minLines: 10,
                            maxLines: 30,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                              hintText: 'Cole ou digite a letra aqui...',
                              hintStyle: AppFonts.defaultFont(
                                color: AppColors.grey5,
                                fontSize: 14,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                              fillColor: AppColors.white,
                              filled: true,
                              contentPadding: const EdgeInsets.all(12),
                            ),
                            style: AppFonts.defaultFont(
                              color: AppColors.grey10,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'Cancelar',
                                  style: AppFonts.defaultFont(
                                    color: AppColors.redModal,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.add,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 12,
                                  ),
                                ),
                                child: Text(
                                  'Adicionar',
                                  style: AppFonts.defaultFont(
                                    color: AppColors.white,
                                    fontSize: 16,
                                  ),
                                ),
                                onPressed: () {
                                  if(widget.callback!= null) widget.callback!(_lyricsController.text);
                                },
                              ),
                            ],
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
    );
  }
}
