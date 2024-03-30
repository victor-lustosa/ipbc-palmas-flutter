
import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';


class GuidelineWidget extends StatelessWidget {
  const GuidelineWidget({Key? key, required this.liturgiesList, required this.timelineColor, required this.circleColor})
      : super(key: key);
  final List<LiturgyEntity> liturgiesList;
  final Color timelineColor;
  final Color circleColor;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: liturgiesList.length,
      itemBuilder: (context, index) {
        return Row(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  width: 1,
                  height: liturgiesList[index].isAdditional
                      ? 29
                      : 18,
                  color: index == 0
                      ? AppColors.white
                      : timelineColor,
                ),
                Container(
                  width: 6,
                  height: 6,
                  margin: const EdgeInsets.only(left: 6, right: 6),
                  decoration: BoxDecoration(
                    color: circleColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                Container(
                  width: 1,
                  height: liturgiesList[index].isAdditional
                      ? 28
                      : 18,
                  color: index == liturgiesList.length - 1
                      ? AppColors.white
                      : timelineColor,
                ),
              ],
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      liturgiesList[index].sequence,
                      style: AppFonts.defaultFont(
                        color: AppColors.grey9,
                        fontSize: 17,
                      ),
                    ),
                    Visibility(
                      visible: liturgiesList[index].isAdditional,
                      child: Container(
                        margin: const EdgeInsets.only(top: 4),
                        child: Text(
                          liturgiesList[index].additional,
                          style: AppFonts.defaultFont(
                            color: AppColors.grey8,
                            fontSize: 13,
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
