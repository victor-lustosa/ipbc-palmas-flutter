import 'package:flutter/material.dart';

import '../../configs/app_configs.dart';
import '../../../lyric/domain/entities/liturgy_entity.dart';

class GuidelineWidget extends StatelessWidget {
  const GuidelineWidget({Key? key, required this.liturgyList})
      : super(key: key);
  final List<LiturgyEntity> liturgyList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: liturgyList.length,
      itemBuilder: (context, index) {
        return Row(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  width: 2,
                  height: 21,
                  color:
                      index == 0 ? Colors.white : AppColors.timelineGuideTGreen,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 5, right: 5),
                  padding: const EdgeInsets.all(3.2),
                  decoration: BoxDecoration(
                    color: AppColors.timelineCircleGreen,
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                Container(
                  width: 2,
                  height: 21,
                  color: index == liturgyList.length - 1
                      ? Colors.white
                      : AppColors.timelineGuideTGreen,
                ),
              ],
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                height: 32.5,
                child: Row(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        liturgyList[index].sequence,
                        style: const TextStyle(
                          fontSize: 18,
                          color: AppColors.timelinePrimary,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: liturgyList[index].isAdditional,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 13, top: 2),
                        child: Text(
                          liturgyList[index].additional,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.timelineSecondary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
