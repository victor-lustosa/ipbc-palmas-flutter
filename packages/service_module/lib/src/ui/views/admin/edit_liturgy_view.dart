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
                        return GestureDetector(
                          key: Key('${_liturgiesList[index].id}'),
                          onLongPress: () {
                            Modular.get<EditLiturgyViewModel>().entity =
                                _liturgiesList[index];
                            Modular.get<EditLiturgyViewModel>().index = index;
                            showEditLiturgiesDialog(context: context);
                          },
                          child: Container(
                            color: Colors.transparent,
                            padding: const EdgeInsets.only(top: 8, bottom: 8),
                            child: Container(
                              decoration: const BoxDecoration(
                                color: AppColors.secondaryGrey2,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(16),
                                ),
                              ),
                              child: Row(
                                children: [
                                  GridBallsTileWidget(index: index),
                                  Container(
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
                                              _liturgiesList[index]
                                                  .isAdditional,
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                              top: 4,
                                            ),
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
                                ],
                              ),
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
                            final scale = lerpDouble(1, 1.05, animValue)!;
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
            action:
                () => popAndPushNamed(
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
}
