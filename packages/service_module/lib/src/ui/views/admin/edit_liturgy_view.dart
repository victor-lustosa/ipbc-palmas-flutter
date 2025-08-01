import 'dart:ui';
import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

import '../../components/dialogs/admin/edit_liturgies_dialog_widget.dart';
import '../../stores/admin/edit_liturgy_view_model.dart';
import '../../stores/admin/services_preview_store.dart';

class EditLiturgyDTO {
  EditLiturgyDTO({required this.heading, required this.image});

  final String heading;
  final String image;
}

class EditLiturgyView extends StatefulWidget {
  const EditLiturgyView({super.key, required this.dto});

  final EditLiturgyDTO dto;

  @override
  State<EditLiturgyView> createState() => _EditLiturgyViewState();
}

class _EditLiturgyViewState extends State<EditLiturgyView> {
  late EditLiturgyViewModel _editLiturgyViewModel;
  late List<LiturgyModel> _liturgiesList;

  int? _longPressedIndex;

  @override
  void initState() {
    super.initState();
    _editLiturgyViewModel = Modular.get<EditLiturgyViewModel>();
    setLightAppBar();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _editLiturgyViewModel,
      builder: (context, child) {
        _liturgiesList = _editLiturgyViewModel.items;
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              color: AppColors.white,
              width: context.sizeOf.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ServiceTopBarWidget(
                    image: widget.dto.image,
                    title: "Cultos de ${widget.dto.heading}",
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      left: 16.5,
                      top: 24.7,
                      bottom: 8,
                    ),
                    child: Text(
                      'Edite a liturgia do culto:',
                      style: AppFonts.defaultFont(
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                        color: AppColors.grey10,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      bottom: 40,
                    ),
                    child: ReorderableListView.builder(
                      shrinkWrap: true,
                      itemCount: _liturgiesList.length,
                      buildDefaultDragHandles: false,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        final currentLiturgy = _liturgiesList[index];
                        final GlobalKey itemKey = GlobalKey();

                        final Widget itemContent = Container(
                          decoration: const BoxDecoration(
                            color: AppColors.secondaryGrey2,
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                          child: Row(
                            children: [
                              GridBallsTileWidget(index: index),
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.only(
                                    bottom: 8,
                                    top: 8,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        _liturgiesList[index].sequence,
                                        style: AppFonts.defaultFont(
                                          color: AppColors.grey9,
                                          fontSize: 17,
                                        ),
                                      ),
                                      Visibility(
                                        visible:
                                            _liturgiesList[index].isAdditional,
                                        child: Container(
                                          margin: const EdgeInsets.only(top: 4),
                                          child: Text(
                                            _liturgiesList[index].isAdditional
                                                ? _liturgiesList[index]
                                                      .additional!
                                                : '',
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
                              ),
                            ],
                          ),
                        );

                        return Container(
                          key: ValueKey(currentLiturgy),
                          padding: const EdgeInsets.only(top: 8, bottom: 8),
                          child: Opacity(
                            opacity: _longPressedIndex == index ? 0.0 : 1.0,
                            child: GestureDetector(
                              key: itemKey,
                              onLongPressStart: (details) async {
                                setState(() {
                                  _longPressedIndex = index;
                                });
                                await _showLiturgyOptionsPopup(
                                  context,
                                  itemKey,
                                  itemContent,
                                );
                                setState(() {
                                  _longPressedIndex = null;
                                });
                              },
                              child: itemContent,
                            ),
                          ),
                        );
                      },
                      onReorder: (int oldIndex, int newIndex) {
                        setState(() {
                          if (oldIndex < newIndex) {
                            newIndex -= 1;
                          }
                          final LiturgyModel item = _liturgiesList.removeAt(
                            oldIndex,
                          );
                          _liturgiesList.insert(newIndex, item);
                        });
                      },
                      proxyDecorator: (Widget child, _, animation) {
                        return AnimatedBuilder(
                          animation: animation,
                          builder: (BuildContext context, Widget? child) {
                            final animValue = Curves.easeInOut.transform(
                              animation.value,
                            );
                            final scale = lerpDouble(1, 1.1, animValue)!;
                            return Transform.scale(scale: scale, child: child);
                          },
                          child: child,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingButtonWidget(
            icon: Icons.check_rounded,
            backgroundColor: AppColors.confirmation,
            iconColor: AppColors.grey10,
            size: 33,
            action: () => popAndPushNamed(
              AppRoutes.servicesRoute + AppRoutes.servicesPreviewRoute,
              arguments: ServicesPreviewDTO(
                heading: widget.dto.heading,
                image: widget.dto.image,
                liturgiesList: _liturgiesList,
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _showLiturgyOptionsPopup(
    BuildContext context,
    GlobalKey itemKey,
    Widget itemContent,
  ) async {
    final RenderBox renderBox =
        itemKey.currentContext!.findRenderObject() as RenderBox;
    final itemOffset = renderBox.localToGlobal(Offset.zero);
    final itemSize = renderBox.size;

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    const popupWidth = 180.0;
    const popupHeight = 220.0;
    const screenEdgeMargin = 16.0;

    final double popupLeft = screenWidth - popupWidth - screenEdgeMargin;

    const double verticalMargin = 3.0;
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
      pageBuilder:
          (
            BuildContext buildContext,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            // ✅ CORREÇÃO: O Stack agora usa IgnorePointer para o fundo.
            return Stack(
              children: [
                // --- CAMADA DE FUNDO (IGNORA CLIQUES) ---
                IgnorePointer(
                  ignoring: true,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                          child: Container(
                            color: Colors.black.withOpacity(0.2),
                          ),
                        ),
                      ),
                      Positioned(
                        top: itemOffset.dy,
                        left: itemOffset.dx,
                        child: SizedBox(
                          width: itemSize.width,
                          height: itemSize.height,
                          child: Transform.scale(
                            scale: 1.1,
                            child: Material(
                              color: Colors.transparent,
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 16),
                                child: itemContent,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // --- CAMADA INTERATIVA (NÃO IGNORA CLIQUES) ---
                Positioned(
                  top: popupTop,
                  left: popupLeft,
                  child: LiturgyOptionsPopup(
                    width: popupWidth,
                    onAddBox: () {
                      Navigator.of(context).pop();
                    },
                    onDuplicate: () {
                      Navigator.of(context).pop();
                    },
                    onDelete: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            );
          },
    );
  }
}

class LiturgyOptionsPopup extends StatelessWidget {
  const LiturgyOptionsPopup({
    super.key,
    required this.onAddBox,
    required this.onDuplicate,
    required this.onDelete,
    required this.width,
  });

  final VoidCallback onAddBox;
  final VoidCallback onDuplicate;
  final VoidCallback onDelete;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildOption(
                context: context,
                icon: Icons.add_box,
                label: 'Add Box',
                onTap: onAddBox,
              ),
              _buildOption(
                context: context,
                icon: Icons.copy,
                label: 'Duplicar',
                onTap: onDuplicate,
              ),
              _buildOption(
                context: context,
                icon: Icons.delete,
                label: 'Deletar',
                onTap: onDelete,
              ),
              const Divider(),
              _buildOption(
                context: context,
                icon: Icons.cancel,
                label: 'Cancelar',
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOption({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: Row(
          children: [
            Icon(icon, size: 24),
            const SizedBox(width: 16),
            Expanded(child: Text(label, style: const TextStyle(fontSize: 16))),
          ],
        ),
      ),
    );
  }
}
