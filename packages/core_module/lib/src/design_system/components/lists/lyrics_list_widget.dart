import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class LyricsListWidget extends StatefulWidget {
  const LyricsListWidget({
    this.onLongPressStart,
    super.key,
    this.onTap,
    this.margin,
    this.isTitleVisible,
    this.title,
    this.entitiesList,
    this.isLongPressEnabled = true,
    this.keepSelection = false,
    this.isListVisible = false,
  });

  final void Function(LongPressStartDetails)? onLongPressStart;
  final bool isLongPressEnabled;
  final bool keepSelection;
  final void Function()? onTap;
  final EdgeInsetsGeometry? margin;
  final bool? isTitleVisible;
  final bool isListVisible;
  final String? title;
  final List<LyricEntity>? entitiesList;

  @override
  State<LyricsListWidget> createState() => _LyricsListWidgetState();
}

class _LyricsListWidgetState extends State<LyricsListWidget> {
  late final LyricsListStore _store;

  @override
  void initState() {
    super.initState();
    _store = Modular.get<LyricsListStore>();
    if (widget.entitiesList != null) {
      _store.hasFixedData = widget.entitiesList!.isNotEmpty;
    } else {
      _store.hasFixedData = false;
    }

  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _store,
      builder: (_, state, child) {
        if (state is DataFetchedState || state is InitialState || state is RefreshingState) {
          return Visibility(
            visible: (widget.entitiesList ?? _store.entitiesList).isNotEmpty || widget.isListVisible,
            child: Container(
              margin: widget.margin ?? EdgeInsets.only(bottom: 24, left: 16, right: 16),
              child: Column(
                children: [
                  Visibility(
                    visible: widget.isTitleVisible ?? true,
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                            top: 24,
                            left: 2,
                            bottom: 16,
                          ),
                          child: Text(
                            _store.title,
                            style: AppFonts.defaultFont(
                              color: AppColors.grey12,
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    separatorBuilder: (_, _) {
                      return const SizedBox(height: 8);
                    },
                    padding: .zero,
                    scrollDirection: .vertical,
                    shrinkWrap: true,
                    itemCount: (widget.entitiesList ?? _store.entitiesList).length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (_, index) {
                      final GlobalKey itemKey = GlobalKey();
                      final Widget itemContent = AspectRatio(
                        aspectRatio: 343 / 63,
                        child: Row(
                          mainAxisAlignment: .spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                      right: 8,
                                      left: 8,
                                    ),
                                    child: AlbumCoverWidget(
                                      albumCover:
                                          (widget.entitiesList ??
                                                  _store.entitiesList)[index]
                                              .albumCover,
                                      height: ResponsivityUtil<double>(
                                        sm: 48,
                                        xl: 52,
                                      ).get(context),
                                      width: ResponsivityUtil<double>(
                                        sm: 48,
                                        xl: 52,
                                      ).get(context),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: .center,
                                      crossAxisAlignment: .start,
                                      children: [
                                        Text(
                                          maxLines: 2,
                                          overflow: .ellipsis,
                                          (widget.entitiesList ?? _store.entitiesList)[index].title,
                                          style: AppFonts.subhead(
                                            fontWeight: .w500,
                                            color: AppColors.grey9,
                                            fontSize: ResponsivityUtil<double>(
                                              sm: 15,
                                              xl: 16,
                                            ).get(context),
                                          ),
                                        ),
                                        Text(
                                          (widget.entitiesList ?? _store.entitiesList)[index].artist,
                                          style: AppFonts.description(
                                            color: AppColors.grey9,
                                            fontSize: ResponsivityUtil<double>(
                                              sm: 13,
                                              xl: 14,
                                            ).get(context),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                right: ResponsivityUtil.isSmallDevice(context)
                                    ? 7
                                    : 12,
                              ),
                              child: IconButtonWidget(
                                height: 33,
                                width: 33,
                                sizeIcon: 21,
                                color: AppColors.darkGreen,
                                iconFormat: .svg,
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                iconPath: AppIcons.arrowForward,
                              ),
                            ),
                          ],
                        ),
                      );

                      final BoxDecoration defaultDecoration = BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                      );

                      final BoxDecoration tappedDecoration = BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF92E9D9), Color(0x54B6F6EA)],
                          begin: .centerLeft,
                          end: .centerRight,
                        ),
                      );

                      return ValueListenableBuilder<int?>(
                        valueListenable: _store.tappedIndex,
                        builder: (context, tappedIndex, child) {
                          final bool isTapped = tappedIndex == index;

                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                            decoration: isTapped
                                ? tappedDecoration
                                : defaultDecoration,
                            child: GestureDetector(
                              key: itemKey,
                              onLongPressStart: (details) async {
                                if (widget.isLongPressEnabled) {
                                  _store.index = index;
                                  _store.itemKey = itemKey;
                                  _store.tappedIndex.value = index;
                                  _store.selectedLyric = (widget.entitiesList ?? _store.entitiesList)[index];
                                  widget.onLongPressStart?.call(details);
                                }
                              },
                              child: InkWell(
                                onTap: () {
                                  _store.selectedLyric = (widget.entitiesList ?? _store.entitiesList)[index];
                                  if (_store.tappedIndex.value == index && widget.keepSelection) {
                                    _store.tappedIndex.value = null;
                                  } else {
                                    _store.tappedIndex.value = index;
                                  }
                                  widget.onTap?.call();
                                  if (!widget.keepSelection) {
                                    Future.delayed(const Duration(milliseconds: 300), () {
                                      if (mounted && _store.tappedIndex.value == index) {
                                        _store.tappedIndex.value = null;
                                      }
                                    });
                                  }
                                },
                                child: itemContent,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        } else if (state is NotFoundState) {
          return SizedBox(
            width: context.sizeOf.width,
            height: context.sizeOf.height * .45,
            child: Column(
              mainAxisAlignment: .center,
              children: [
                SizedBox(
                  width: 26,
                  height: 26,
                  child: Image.asset(AppIcons.info, color: Colors.blueAccent),
                ),
                Container(
                  margin: EdgeInsets.only(top: 8),
                  child: Text(
                    textAlign: .center,
                    style: AppFonts.defaultFont(
                      fontSize: ResponsivityUtil<double>(
                        sm: 13,
                        xl: 14,
                      ).get(context),
                      color: AppColors.grey9,
                    ),
                    'Nenhuma letra encontrada.',
                  ),
                ),
              ],
            ),
          );
        }  else if (state is NoConnectionState) {
          return Center(
            child: SizedBox(
              width: context.sizeOf.width,
              height: context.sizeOf.width * .6,
              child: Column(
                crossAxisAlignment: .center,
                mainAxisAlignment: .center,
                children: [
                  SizedBox(
                    width: 26,
                    height: 26,
                    child: Image.asset(AppIcons.info, color: Colors.blueAccent),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    child: Text(
                      textAlign: .center,
                      style: AppFonts.defaultFont(
                        fontSize: ResponsivityUtil<double>(
                          sm: 13,
                          xl: 14,
                        ).get(context),
                        color: AppColors.grey9,
                      ),
                      'Sem conexão.',
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return SizedBox(
            height: context.sizeOf.height * .42,
            width: context.sizeOf.width,
            child: const LoadingWidget(
              androidRadius: 3,
              iosRadius: 14,
              color: AppColors.darkGreen,
            ),
          );
        }
      },
    );
  }
}
