import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class VersesListWidget extends StatelessWidget {
  const VersesListWidget({
    super.key,
    required this.entity,
    required this.isEdit,
  });

  final bool isEdit;
  final List<VerseEntity> entity;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: entity.length,
      itemBuilder: (_, index) {
        return Container(
          decoration: const BoxDecoration(color: AppColors.white),
          margin:
              entity[index].isChorus
                  ? const EdgeInsets.only(left: 20, right: 16)
                  : const EdgeInsets.only(left: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(isEdit ? 0 : 16)),
            child: Container(
              decoration: BoxDecoration(
                color:
                    entity[index].isChorus
                        ? AppColors.chorusColor
                        : (isEdit ? AppColors.searchBar : AppColors.white),
              ),
              child: Container(
                margin: const EdgeInsets.all(16),
                child: ListView.separated(
                  separatorBuilder: (__, _) {
                    return const SizedBox(height: 6);
                  },
                  itemCount: entity[index].versesList.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: ((__, position) {
                    return Text(
                      entity[index].versesList[position],
                      style: AppFonts.defaultFont(
                        color: AppColors.grey10,
                        fontSize:
                            context.sizeOf.width >
                                    ResponsivityUtil.smallDeviceWidth
                                ? 16
                                : 14,
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
