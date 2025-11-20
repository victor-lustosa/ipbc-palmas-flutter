import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../components/dialogs/admin/add_lyrics_dialog_widget.dart';

class SearchLyricsView extends StatefulWidget {
  const SearchLyricsView({super.key});

  @override
  State<SearchLyricsView> createState() => _SearchLyricsViewState();
}

class _SearchLyricsViewState extends State<SearchLyricsView> {
  late final SearchLyricsStore _store;

  @override
  void initState() {
    super.initState();
    _store = Modular.get<SearchLyricsStore>();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: SafeArea(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    color: AppColors.white,
                    width: context.sizeOf.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ServiceTopBarWidget(
                          image: _store.servicesEntity.image,
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
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                              color: AppColors.grey10,
                            ),
                          ),
                        ),
                        SearchWidget(),
                        Container(
                          margin: const EdgeInsets.only(top: 14),
                          child: LyricsListWidget(
                            onTap: () async{
                              FocusScope.of(context).unfocus();
                              await Future.delayed(Duration.zero);

                              if (!context.mounted) return;
                              pushNamed(
                                AppRoutes.lyricsRoute + AppRoutes.lyricRoute,
                                arguments: _store.lyricsListStore.lyricEntity,
                              );
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
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: context.sizeOf.width,
                      color: AppColors.white,
                      padding: const EdgeInsets.only(bottom: 10, top: 20),
                      child: Visibility(
                        visible: true,
                        child: LoadingButtonWidget(
                          margin: EdgeInsets.symmetric(horizontal: 16),
                          isPressed: _store.isAddEventPressed,
                          adaptiveButtonType: AdaptiveButtonType.outlined,
                          sideColor: AppColors.darkGreen,
                          outlinedBorderWidth: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          backgroundColor: AppColors.white,
                          shadowColor: AppColors.grey0,
                          sideHoveredColor: AppColors.highlightGreen,
                          foregroundHoveredColor: AppColors.darkGreen,
                          foregroundColor: AppColors.darkGreen,
                          action: () async {
                            showAddLyricsDialog(
                              context: context,
                              callback: (text) {
                                _store.newLyric(text, context);
                              },
                            );
                          },
                          label: "Adicionar nova música",
                          isValid: ValueNotifier(true),
                        ),
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