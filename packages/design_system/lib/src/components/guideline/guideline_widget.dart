
import 'package:flutter/material.dart';

import '../../../design_system.dart';

class GuidelineWidget extends StatelessWidget {
  const GuidelineWidget({Key? key, required this.liturgiesList})
      : super(key: key);
  final List<dynamic> liturgiesList;

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
                  width: 1.7,
                  height: liturgiesList[index].isAdditional
                      ? 29
                      : 18,
                  color: index == 0
                      ? Colors.white
                      : AppColors.timelineGuideTGreen,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 5, right: 5),
                  padding: const EdgeInsets.all(3.2),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryGreen,
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                Container(
                  width: 2,
                  height: liturgiesList[index].isAdditional
                      ? 28
                      : 18,
                  color: index == liturgiesList.length - 1
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
