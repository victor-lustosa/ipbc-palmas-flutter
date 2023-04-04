import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import '../../../shared/components/button/button_widget.dart';
import '../../../shared/configs/app_configs.dart';
import '../../../shared/configs/app_routes.dart';
import '../../domain/entities/lyric_entity.dart';

class LyricsListWidget extends StatefulWidget {
  const LyricsListWidget({Key? key, required this.lyricsList})
      : super(key: key);
  final List<LyricEntity> lyricsList;

  @override
  State<LyricsListWidget> createState() => _LyricsListWidgetState();
}

class _LyricsListWidgetState extends State<LyricsListWidget> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        splashColor: const Color(0x66C8C8C8),
        highlightColor: const Color(0x66BCBCBC),
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.93,
        child: ListView.separated(
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              height: 4,
            );
          },
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: widget.lyricsList.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Material(
              borderRadius: BorderRadius.circular(10),
              clipBehavior: Clip.hardEdge,
              color: AppColors.white,
              child: ListTile(
                contentPadding: const EdgeInsets.only(
                  top: 2,
                  bottom: 2,
                  left: 8,
                  right: 0,
                ),
                dense: true,
                minVerticalPadding: 0,
                minLeadingWidth: 0,
                horizontalTitleGap: 4,
                leading: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(11),
                  ),
                  child: SizedBox(
                    width: 50,
                    height: 80,
                    child: widget.lyricsList[index].albumCover.contains("assets")
                        ? Image.asset(
                            widget.lyricsList[index].albumCover,
                            width: 50,
                            height: 80,
                          )
                        : Image.network(
                            fit: BoxFit.fill,
                            frameBuilder: (BuildContext context, Widget child,
                                int? frame, bool wasSynchronouslyLoaded) {
                              if (wasSynchronouslyLoaded) {
                                return child;
                              }
                              return Container(
                                color: AppColors.lightGrey,
                                width: 50,
                                height: 80,
                              );
                            },
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              return Container(
                                color: AppColors.lightGrey,
                                width: 50,
                                height: 80,
                              );
                            },
                            widget.lyricsList[index].albumCover,
                          ),
                  ),
                ),
                title: Padding(
                  padding: const EdgeInsets.only(
                    bottom: 4, left: 4
                  ),
                  child: Text(
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    widget.lyricsList[index].title,
                    style: AppFonts.lyricsTitleTile,
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(
                       left: 4
                  ),
                  child: Text(
                    widget.lyricsList[index].group,
                    style: AppFonts.subtitleTile,
                  ),
                ),
                trailing:IconButtonWidget(
                    size: Platform.isIOS ? 29 : 36,
                    color: AppColors.darkGreen,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    iOSIcon: CupertinoIcons.chevron_forward,
                    androidIcon: Icons.navigate_next_sharp,
                    action: () => Navigator.of(context, rootNavigator: true).pushNamed(
                          AppRoutes.lyricRoute,
                          arguments: widget.lyricsList[index],
                        )
                ),

                onTap: () {
                  Navigator.of(context, rootNavigator: true).pushNamed(
                    AppRoutes.lyricRoute,
                    arguments: widget.lyricsList[index],
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
