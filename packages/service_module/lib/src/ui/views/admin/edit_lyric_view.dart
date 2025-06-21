import 'dart:ui';

import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';
import 'package:service_module/src/ui/stores/admin/edit_lyric_store.dart';
import 'package:flutter/services.dart'; // Import necessário para HapticFeedback

class EditLyricView extends StatefulWidget {
  const EditLyricView({super.key, required this.entity});

  final LyricEntity entity;

  @override
  State<EditLyricView> createState() => _EditLyricViewState();
}

class _EditLyricViewState extends State<EditLyricView> {
  final EditLyricStore _store = Modular.get<EditLyricStore>();

  final Map<String, TextEditingController> _controllers = {};
  final Map<String, FocusNode> _focusNodes = {};
// Variável de estado para saber se algum TextFormField está focado
  bool _isAnyTextFieldFocused = false;
  // FocusNode raiz para monitorar o FocusScope global
  late FocusScopeNode _rootFocusNode;

  @override
  void initState() {
    super.initState();
    setDarkAppBar();
    _store.initial();
    _initializeControllersAndFocusNodes();

    // Inicializa o FocusNode raiz e adiciona um listener para mudanças de foco
    _rootFocusNode = FocusScopeNode(); // Instancia um FocusScopeNode
    _rootFocusNode.addListener(_handleRootFocusChange);
  }

  // Listener para o FocusNode raiz que atualiza _isAnyTextFieldFocused
  void _handleRootFocusChange() {
    // Verifica se o status de foco global mudou
    if (_isAnyTextFieldFocused != _rootFocusNode.hasFocus) {
      setState(() {
        _isAnyTextFieldFocused = _rootFocusNode.hasFocus;
      });
    }
  }

  void _initializeControllersAndFocusNodes() {
    for (int i = 0; i < widget.entity.verses.length; i++) {
      final verse = widget.entity.verses[i];
      for (int j = 0; j < verse.versesList.length; j++) {
        final key = '${verse.id}_$j';
        _controllers[key] = TextEditingController(text: verse.versesList[j]);
        _focusNodes[key] = FocusNode();
      }
    }
  }

  void _updateControllersAndFocusNodes() {
    final Set<String> currentKeys = {};
    for (int i = 0; i < widget.entity.verses.length; i++) {
      final verse = widget.entity.verses[i];
      for (int j = 0; j < verse.versesList.length; j++) {
        final key = '${verse.id}_$j';
        currentKeys.add(key);

        // Controller
        if (!_controllers.containsKey(key)) {
          _controllers[key] = TextEditingController(text: verse.versesList[j]);
        } else {
          if (_controllers[key]!.text != verse.versesList[j]) {
            final TextSelection previousSelection =
                _controllers[key]!.selection;
            _controllers[key]!.text = verse.versesList[j];
            _controllers[key]!.selection = previousSelection.copyWith(
              baseOffset: previousSelection.baseOffset.clamp(
                0,
                _controllers[key]!.text.length,
              ),
              extentOffset: previousSelection.extentOffset.clamp(
                0,
                _controllers[key]!.text.length,
              ),
            );
          }
        }

        // FocusNode
        if (!_focusNodes.containsKey(key)) {
          _focusNodes[key] = FocusNode();
        }
      }
    }

    _controllers.keys.toList().forEach((key) {
      if (!currentKeys.contains(key)) {
        _controllers.remove(key)?.dispose();
        _focusNodes.remove(key)?.dispose();
      }
    });
  }

  @override
  void dispose() {
    _controllers.forEach((key, controller) => controller.dispose());
    _focusNodes.forEach((key, focusNode) => focusNode.dispose());
    _rootFocusNode.removeListener(_handleRootFocusChange);
    _rootFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FocusScope( // Envolve o Scaffold com um FocusScope para usar _rootFocusNode
      node: _rootFocusNode,
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: ValueListenableBuilder(
              valueListenable: _store,
              builder: (_, state, child) {
                if (state is LoadingState<EditLyricState>) {
                  return const LoadingWidget(
                    androidRadius: 3,
                    iosRadius: 14,
                    color: AppColors.darkGreen,
                  );
                } else {
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                            left: 16.5,
                            top: 24.7,
                            bottom: 16,
                          ),
                          child: Text(
                            'Edite a letra:',
                            style: AppFonts.defaultFont(
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                              color: AppColors.grey10,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 19, right: 19),
                          child: ReorderableListView.builder(
                            shrinkWrap: true,
                            itemCount: widget.entity.verses.length,
                            buildDefaultDragHandles: false,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              final verse = widget.entity.verses[index];
                              return Container(
                                key: Key('${verse.id}'),
                                margin: const EdgeInsets.symmetric(vertical: 8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(16),
                                  ),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: AppColors.secondaryGrey2,
                                    ),
                                    child: Row(
                                      children: [
                                        IgnorePointer(
                                          ignoring: _isAnyTextFieldFocused,
                                          child: ReorderableDelayedDragStartListener(
                                            index: index,
                                            child: GestureDetector(
                                              onLongPressStart: (_) {
                                                FocusScope.of(context).unfocus();
                                                HapticFeedback.lightImpact();
                                              },
                                              child: GridBallsTileWidget(
                                                index: index,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                              left: 3,
                                              top: 14,
                                              bottom: 14,
                                              right: 14,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: List.generate(verse.versesList.length, (
                                                position,
                                              ) {
                                                final lineKey =
                                                    '${verse.id}_$position';
                                                if (!_controllers.containsKey(
                                                  lineKey,
                                                )) {
                                                  _controllers[lineKey] =
                                                      TextEditingController(
                                                        text:
                                                            verse
                                                                .versesList[position],
                                                      );
                                                }
                                                if (!_focusNodes.containsKey(
                                                  lineKey,
                                                )) {
                                                  _focusNodes[lineKey] =
                                                      FocusNode();
                                                }
                                                if (_controllers[lineKey]!.text !=
                                                    verse.versesList[position]) {
                                                  final TextSelection
                                                  previousSelection =
                                                      _controllers[lineKey]!
                                                          .selection;
                                                  _controllers[lineKey]!.text =
                                                      verse.versesList[position];
                                                  _controllers[lineKey]!
                                                          .selection =
                                                      previousSelection.copyWith(
                                                        baseOffset: previousSelection
                                                            .baseOffset
                                                            .clamp(
                                                              0,
                                                              _controllers[lineKey]!
                                                                  .text
                                                                  .length,
                                                            ),
                                                        extentOffset:
                                                            previousSelection
                                                                .extentOffset
                                                                .clamp(
                                                                  0,
                                                                  _controllers[lineKey]!
                                                                      .text
                                                                      .length,
                                                                ),
                                                      );
                                                }
      
                                                return Padding(
                                                  padding: EdgeInsets.only(
                                                    bottom:
                                                        position ==
                                                                verse
                                                                        .versesList
                                                                        .length -
                                                                    1
                                                            ? 0
                                                            : 6,
                                                  ),
                                                  child: TextFormField(
                                                    controller:
                                                        _controllers[lineKey],
                                                    focusNode:
                                                        _focusNodes[lineKey],
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      isDense: true,
                                                      contentPadding:
                                                          EdgeInsets.zero,
                                                    ),
                                                    style: AppFonts.defaultFont(
                                                      color: AppColors.grey10,
                                                      fontSize:
                                                          context.sizeOf.width >
                                                                  ResponsivityUtil
                                                                      .smallDeviceWidth
                                                              ? 16
                                                              : 14,
                                                    ),
                                                    maxLines: null,
                                                    keyboardType:
                                                        TextInputType.multiline,
                                                    onChanged: (newValue) {
                                                      verse.versesList[position] =
                                                          newValue;
                                                    },
                                                  ),
                                                );
                                              }),
                                            ),
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
                                final VerseEntity item = widget.entity.verses
                                    .removeAt(oldIndex);
                                widget.entity.verses.insert(newIndex, item);
                                _updateControllersAndFocusNodes();
                              });
                            },
                            proxyDecorator: (Widget child, int index, animation) {
                              return Material(
                                color: Colors.transparent,
                                child: AnimatedBuilder(
                                  animation: animation,
                                  builder: (BuildContext context, Widget? _) {
                                    final animValue = Curves.easeInOut.transform(
                                      animation.value,
                                    );
                                    final scale = lerpDouble(1, 1.05, animValue)!;
      
                                    return LayoutBuilder(
                                      builder: (innerContext, constraints) {
                                        final double childHeight =
                                            constraints.maxHeight.isFinite &&
                                                    constraints.maxHeight > 0
                                                ? constraints.maxHeight
                                                : 100.0;
      
                                        final double scaleCompensationOffset =
                                            childHeight * (scale - 1) / 2;
                                        final double gapCompensationOffset =
                                            childHeight * 0.2;
      
                                        return Transform.translate(
                                          offset: Offset(
                                            0,
                                            -scaleCompensationOffset +
                                                gapCompensationOffset,
                                          ),
                                          child: Transform.scale(
                                            scale: scale,
                                            child: child,
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: child,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ),
        floatingActionButton: FloatingButtonWidget(
          icon: Icons.check_rounded,
          backgroundColor: AppColors.confirmation,
          iconColor: AppColors.grey10,
          size: 33,
          action: () {
            FocusScope.of(context).unfocus();
            pushNamed(
              AppRoutes.servicesRoute + AppRoutes.servicesPreviewRoute,
              arguments: widget.entity,
            );
          },
        ),
      ),
    );
  }
}
