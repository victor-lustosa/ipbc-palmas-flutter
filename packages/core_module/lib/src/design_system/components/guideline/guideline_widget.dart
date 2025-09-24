import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class GuidelineWidget extends StatelessWidget {
  const GuidelineWidget({
    super.key,
    required this.liturgiesList,
    required this.timelineColor,
    required this.circleColor,
  });

  final List<LiturgyEntity> liturgiesList;
  final Color timelineColor;
  final Color circleColor;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: liturgiesList.length,
      itemBuilder: (context, index) {
        return Row(
          children: [
            Column(
              children: [
                Container(
                  width: 1,
                  height:
                      liturgiesList[index].isAdditional &&
                          liturgiesList[index].additional != null
                      ? 29
                      : 18,
                  color: index == 0 ? AppColors.white : timelineColor,
                ),
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: circleColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                Container(
                  width: 1,
                  height:
                      liturgiesList[index].isAdditional &&
                          liturgiesList[index].additional != null
                      ? 29
                      : 18,
                  color: index == liturgiesList.length - 1
                      ? AppColors.white
                      : timelineColor,
                ),
              ],
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(
                  left: 12,
                  bottom: 8,
                  top: 8,
                  right: 0,
                ),
                decoration: const BoxDecoration(color: Colors.white),
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
                      visible:
                          liturgiesList[index].isAdditional &&
                          liturgiesList[index].additional != null,
                      child: Container(
                        margin: const EdgeInsets.only(top: 4),
                        child: Text(
                          (liturgiesList[index].isAdditional &&
                                  liturgiesList[index].additional == null)
                              ? (liturgiesList[index].additional ?? '')
                              : '',
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
            ),
          ],
        );
      },
    );
  }
}
