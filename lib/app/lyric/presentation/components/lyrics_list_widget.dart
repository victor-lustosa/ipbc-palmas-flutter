import 'package:flutter/material.dart';
import 'package:ipbc_palmas/app/lyric/domain/entities/lyric_entity.dart';

import '../../../shared/components/next-button/next_button_widget.dart';
import '../../../shared/configs/app_configs.dart';
import '../../../shared/configs/app_routes.dart';

class LyricsListWidget extends StatelessWidget {
  const LyricsListWidget({Key? key, required this.lyricsList})
      : super(key: key);
  final List<LyricEntity> lyricsList;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(
          height: 12,
        );
      },
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: lyricsList.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return ListTile(
          contentPadding: const EdgeInsets.only(
            left: 25,
            right: 8,
          ),
          dense: true,
          minVerticalPadding: 0,
          minLeadingWidth: 0,
          horizontalTitleGap: 8,
          leading: Container(
            //  decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(11),
              ),
              child: SizedBox(
                width: 50,
                height: 80,
                child: Image.network(
                  fit: BoxFit.fill,
                  lyricsList[index].albumCover,
                ),
              ),
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(
              bottom: 6,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  lyricsList[index].title,
                  style: AppFonts.lyricsTitleTile,
                ),
              ],
            ),
          ),
          subtitle: Text(
            lyricsList[index].group,
            style: AppFonts.subtitleTile,
          ),
          trailing: NextButtonWidget(
              size: 32,
              width: 58,
              route: AppRoutes.lyricRoute,
              arguments: lyricsList[index],
              color: AppColors.darkGreen),
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRoutes.lyricRoute,
              arguments: lyricsList[index],
            );
          },
        );
      },
    );
  }
}
