import 'dart:ui';

import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

import '../../../../service_module.dart';
import 'services_preview_view.dart';

class EditLiturgyDTO {
  EditLiturgyDTO({required this.heading, required this.image});

  final String heading;
  final String image;
}

class EditLiturgiesView extends StatefulWidget {
  const EditLiturgiesView({
    super.key,
    required this.dto,
  });

  final EditLiturgyDTO dto;

  @override
  State<EditLiturgiesView> createState() => _EditLiturgiesViewState();
}

class _EditLiturgiesViewState extends State<EditLiturgiesView> {
  final _items = [
    LiturgyEntity(
        id: 0, isAdditional: false, sequence: 'Oração', additional: ''),
    LiturgyEntity(
        id: 1,
        isAdditional: true,
        sequence: 'Texto Bíblico',
        additional: 'João 10:1-6'),
    LiturgyEntity(
        id: 2,
        isAdditional: true,
        sequence: 'Hino 151',
        additional: 'O Bom Pastor'),
    LiturgyEntity(
        id: 3,
        isAdditional: true,
        sequence: 'Texto Bíblico',
        additional: 'Lucas 15:1-7'),
    LiturgyEntity(
        id: 4,
        isAdditional: false,
        sequence: 'Oração de confissão de pecados',
        additional: ''),
    LiturgyEntity(
        id: 5, isAdditional: false, sequence: 'Cânticos', additional: ''),
    LiturgyEntity(
        id: 6,
        isAdditional: true,
        sequence: 'Pregação',
        additional: 'O Bom Pastor - Salmo 23'),
    LiturgyEntity(
        id: 7, isAdditional: false, sequence: 'Santa Ceia', additional: ''),
    LiturgyEntity(
        id: 8, isAdditional: false, sequence: 'Oração final', additional: ''),
  ];

  @override
  void initState() {
    super.initState();
    setDarkAppBar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: AppColors.white,
          width: context.mediaQuery.size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ServiceTopBarWidget(
                image: widget.dto.image,
                title: "Cultos de ${widget.dto.heading}",
              ),
              Container(
                margin:
                    const EdgeInsets.only(left: 16.5, top: 24.7, bottom: 16),
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
                  left: 19,
                  right: 19,
                  bottom: 24,
                ),
                child: ReorderableListView.builder(
                  shrinkWrap: true,
                  itemCount: _items.length,
                  buildDefaultDragHandles: false,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      key: Key('${_items[index].id}'),
                      onLongPress: () {
                        showCustomOptionsDialog(context: context);
                      },
                      child: Container(
                        color: Colors.transparent,
                        padding: const EdgeInsets.only(
                          top: 8,
                          bottom: 8,
                        ),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: AppColors.searchBar,
                            borderRadius:
                                BorderRadius.all(Radius.circular(16)),
                          ),
                          child: Row(
                            children: [
                              GridBallsTileWidget(index: index),
                              Container(
                                margin: const EdgeInsets.only(
                                  bottom: 12,
                                  top: 12,
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      _items[index].sequence,
                                      style: AppFonts.defaultFont(
                                        color: AppColors.grey9,
                                        fontSize: 17,
                                      ),
                                    ),
                                    Visibility(
                                      visible: _items[index].isAdditional,
                                      child: Container(
                                        margin: const EdgeInsets.only(top: 4),
                                        child: Text(
                                          _items[index].additional,
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
                      final LiturgyEntity item = _items.removeAt(oldIndex);
                      _items.insert(newIndex, item);
                    });
                  },
                  proxyDecorator: (Widget child, _, animation) {
                    return AnimatedBuilder(
                      animation: animation,
                      builder: (BuildContext context, Widget? child) {
                        final animValue =
                            Curves.easeInOut.transform(animation.value);
                        final scale = lerpDouble(1, 1.05, animValue)!;
                        return Transform.scale(
                          scale: scale,
                          child: child,
                        );
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
        action: () => pushNamed(
          ServiceModule.servicesRoute + ServiceModule.servicesPreviewRoute,
          arguments: ServicesPreviewDTO(
            heading: widget.dto.heading,
            image: widget.dto.image,
            liturgiesList: _items,
          ),
        ),
      ),
    );
  }
}
