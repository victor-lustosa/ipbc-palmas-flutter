import 'package:flutter/material.dart';
import 'package:ipbc_palmas/app/lyric/domain/entities/lyric_entity.dart';

import '../../../shared/components/next-button/next_button_widget.dart';
import '../../../shared/configs/app_configs.dart';
import '../../../shared/configs/app_routes.dart';
class LyricsListWidget extends StatelessWidget {
  const LyricsListWidget({Key? key, required this.lyricsList}) : super(key: key);
 final List<LyricEntity> lyricsList;
  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: lyricsList.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return ListTile(
          contentPadding: const EdgeInsets.only(
            top: 4,
            bottom: 4,
            left: 25,
            right: 17,
          ),
          dense: true,
          minVerticalPadding: 0,
          minLeadingWidth: 0,
          horizontalTitleGap: 8,
          leading: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
            child: SizedBox(
              width: 50,
              height: 50,
              child: Image.asset(
                AppImages.userAvatar,
              ),
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(
              bottom: 6.5,
            ),
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  lyricsList[index].title,
                  style: AppFonts.titleTile,
                ),
              ],
            ),
          ),
          subtitle: Text(
            lyricsList[index].group,
            style: AppFonts.subtitleTile,
          ),
          trailing: Container(
            /*  decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.orange,
                                  ),
                                ),*/
              child: NextButtonWidget(
                  route:AppRoutes.lyricRoute,
                  arguments: lyricsList[index],
                  color:AppColors.darkGreen)
          ),
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
