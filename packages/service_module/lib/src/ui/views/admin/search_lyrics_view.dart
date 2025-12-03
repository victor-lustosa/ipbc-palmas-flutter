import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SearchLyricsView extends StatefulWidget {
  const SearchLyricsView({super.key, required this.dto});

  final SearchLyricsDTO dto;

  @override
  State<SearchLyricsView> createState() => _SearchLyricsViewState();
}

class _SearchLyricsViewState extends State<SearchLyricsView> {
  late final SearchLyricsStore _store;

  @override
  void initState() {
    super.initState();
    _store = Modular.get<SearchLyricsStore>();
    _store.init(hashCode);
  }

  @override
  void dispose() {
    _store.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: SafeArea(
          child: GestureDetector(
            behavior: .opaque,
            onTap: () {
              FocusScope.of(context).unfocus();
              _store.lyricsListStore.tappedIndex.value = null;
            },
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    color: AppColors.white,
                    width: context.sizeOf.width,
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        ServiceTopBarWidget(
                          image: widget.dto.servicesEntity.image,
                          title: "Voltar para liturgia",

                        ),
                        Container(
                          margin: const EdgeInsets.only(
                            left: 16,
                            top: 24.7,
                            bottom: 16,
                          ),
                          child: Text(
                            'Selecione a música do culto:',
                            style: AppFonts.defaultFont(
                              fontWeight: .w500,
                              fontSize: 17,
                              color: AppColors.grey10,
                            ),
                          ),
                        ),
                        SearchWidget(storeId: hashCode, startsEmpty: false),
                        Container(
                          margin: const EdgeInsets.only(top: 14),
                          child: LyricsListWidget(
                            isLongPressEnabled: false,
                            keepSelection: true,
                            title: "Resultados encontrados",
                            onTap: () async {
                              FocusScope.of(context).unfocus();
                              await Future.delayed(.zero);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Align(
                    alignment: .bottomCenter,
                    child: Container(
                      width: context.sizeOf.width,
                      color: AppColors.white,
                      padding: const EdgeInsets.only(bottom: 10, top: 2),
                      child: ValueListenableBuilder(
                        valueListenable: _store.lyricsListStore.tappedIndex,
                        builder: (context, value, _) {
                          return Visibility(
                            visible: true,
                            child: LoadingButtonWidget(
                              margin: EdgeInsets.symmetric(horizontal: 16),
                              isPressed: value != null
                                  ? _store.isAddEventPressed
                                  : _store.isAddEventPressed,
                              adaptiveButtonType: value != null
                                  ? .elevated
                                  : .outlined,
                              sideColor: value != null
                                  ? null
                                  : AppColors.darkGreen,
                              outlinedBorderWidth: value != null ? null : 1,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              backgroundColor: value != null
                                  ? AppColors.darkGreen
                                  : AppColors.white,
                              overlayColor: value != null
                                  ? AppColors.darkGreen
                                  : AppColors.white,
                              sideHoveredColor: value != null
                                  ? null
                                  : AppColors.highlightGreen,
                              foregroundHoveredColor: value != null
                                  ? null
                                  : AppColors.darkGreen,
                              foregroundColor: value != null
                                  ? AppColors.white
                                  : AppColors.darkGreen,
                              action: value != null
                                  ? () async {
                                   _store.attachLyric(widget.dto.serviceId!, context);
                                  }
                                  : () async {
                                      showAddLyricsDialog(
                                        context: context,
                                        callback: (text) {
                                         // _store.attachLyric(widget.dto.serviceId!, context, text);
                                        },
                                      );
                                    },
                              label: value != null
                                  ? "Adicionar música"
                                  : "Adicionar nova música",
                              isValid: ValueNotifier(true),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
