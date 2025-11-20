
import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class LyricsListWidget extends StatefulWidget {
  const LyricsListWidget({
    this.onLongPressStart,
    super.key,
    this.onTap,
    this.margin,
  });

  final void Function(LongPressStartDetails)? onLongPressStart;
  final void Function()? onTap;
  final EdgeInsetsGeometry? margin;

  @override
  State<LyricsListWidget> createState() => _LyricsListWidgetState();
}

class _LyricsListWidgetState extends State<LyricsListWidget> {
  late final LyricsListStore _store;

  @override
  void initState() {
    super.initState();
    _store = Modular.get<LyricsListStore>();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _store,
      builder: (_, state, child) {
        if (state is DataFetchedState || state is InitialState) {
          return Visibility(
            visible: _store.entitiesList.isNotEmpty,
            child: Container(
              margin:
                  widget.margin ??
                  const EdgeInsets.only(bottom: 25, left: 16, right: 16),
              child: ListView.separated(
                separatorBuilder: (_, _) {
                  return const SizedBox(height: 8);
                },
                padding: EdgeInsets.zero,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: _store.entitiesList.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (_, index) {
                  final GlobalKey itemKey = GlobalKey();
                  final Widget itemContent = AspectRatio(
                    aspectRatio: 343 / 63,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 8, left: 8),
                                child: AlbumCoverWidget(
                                  albumCover:
                                      _store.entitiesList[index].albumCover,
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      _store.entitiesList[index].title,
                                      style: AppFonts.subhead(
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.grey9,
                                        fontSize: ResponsivityUtil<double>(
                                          sm: 15,
                                          xl: 16,
                                        ).get(context),
                                      ),
                                    ),
                                    Text(
                                      _store.entitiesList[index].group,
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
                            iconFormat: IconFormat.svg,
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
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
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
                            _store.index = index;
                            _store.itemKey = itemKey;
                            _store.tappedIndex.value = index;
                            _store.lyricEntity = _store.entitiesList[index];
                            widget.onLongPressStart?.call(details);
                          },
                          child: InkWell(
                            onTap: () {
                              _store.lyricEntity = _store.entitiesList[index];
                              _store.tappedIndex.value = index;
                              Future.delayed(
                                const Duration(milliseconds: 300),
                                () {
                                  widget.onTap?.call();
                                  if (mounted) {
                                    _store.tappedIndex.value = null;
                                  }
                                },
                              );
                            },
                            child: itemContent,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          );
        } else if (state is NotFoundState) {
          return Container(
            margin: const EdgeInsets.only(top: 150),
            child: SizedBox(
              width: context.sizeOf.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 26,
                    height: 26,
                    child: Image.asset(AppIcons.info, color: Colors.blueAccent),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    width: context.sizeOf.width * .6,
                    child: Text(
                      textAlign: TextAlign.center,
                      style: AppFonts.defaultFont(
                        fontSize: ResponsivityUtil<double>(
                          sm: 13,
                          xl: 14,
                        ).get(context),
                        color: AppColors.grey9,
                      ),
                      'Nenhuma música encontrada.',
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return SizedBox(
            height: context.sizeOf.height * .4,
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
