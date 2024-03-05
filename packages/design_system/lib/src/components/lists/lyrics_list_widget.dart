import 'dart:io';

import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../covers/album_cover_widget.dart';

class LyricsListWidget extends StatefulWidget {
  const LyricsListWidget({Key? key, required this.entitiesList})
      : super(key: key);
  final List<LyricEntity> entitiesList;

  @override
  State<LyricsListWidget> createState() => _LyricsListWidgetState();
}

class _LyricsListWidgetState extends State<LyricsListWidget> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        splashColor: const Color(0x66C8C8C8),
        highlightColor: const Color(0x66BCBCBC),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(
              width: context.mediaQuery.size.width,
              child: ListView.separated(
                separatorBuilder: (__, _) {
                  return const SizedBox(
                    height: 4,
                  );
                },
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: widget.entitiesList.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (__, index) {
                  return Material(
                    borderRadius: BorderRadius.circular(10),
                    clipBehavior: Clip.hardEdge,
                    color: AppColors.white,
                    child: ListTile(
                      horizontalTitleGap: 0,
                      contentPadding: const EdgeInsets.only(left: 10),
                      leading: AlbumCoverWidget(
                        albumCover: widget.entitiesList[index].albumCover,
                        height: 50,
                        width: 50,
                      ),
                      title: Container(
                        margin: const EdgeInsets.only(left: 10,bottom: 5),
                        child: Text(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          widget.entitiesList[index].title,
                          style: AppFonts.subhead(
                            fontWeight: FontWeight.w500,
                            color: AppColors.grey9,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      subtitle: Container(
                        margin: const EdgeInsets.only(left: 10,bottom: 0),
                        child: Text(
                          widget.entitiesList[index].group,
                          style: AppFonts.description(
                            color: AppColors.grey9,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      trailing: SizedBox(
                        width: 45,
                        child: IconButtonWidget(
                          size: Platform.isIOS ? null : 33,
                          color: AppColors.darkGreen,
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          iOSIcon: CupertinoIcons.chevron_forward,
                          androidIcon: Icons.navigate_next_sharp,
                        ),
                      ),
                      onTap: () {
                        Modular.to.pushNamed(
                          '/lyrics/lyric',
                          arguments: widget.entitiesList[index],
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 25)
          ],
        ),
      ),
    );
  }
}
