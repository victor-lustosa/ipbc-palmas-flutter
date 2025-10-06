import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class VersesListWidget extends StatelessWidget {
  const VersesListWidget({super.key, required this.entity});

  final List<VerseEntity> entity;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: entity.length,
      separatorBuilder: (__, index) {
        final currentBlock = entity[index];
        final bool isNextChorus =
            (index < entity.length - 1) && entity[index + 1].isChorus;
        return SizedBox(height: currentBlock.isChorus && isNextChorus ? 0 : 12);
      },
      itemBuilder: (_, index) {
        final currentBlock = entity[index];
        if (!currentBlock.isChorus) {
          return Container(
            margin: EdgeInsets.only(left: 8, right: 40),
            color: AppColors.white,
            child: _buildVerseTextColumn(context, currentBlock.versesList),
          );
        }
        final bool isPreviousChorus = (index > 0) && entity[index - 1].isChorus;
        final bool isNextChorus = (index < entity.length - 1) && entity[index + 1].isChorus;
        const double radiusValue = 16.0;

        BorderRadius borderRadius;
        if (!isPreviousChorus && isNextChorus) {
          borderRadius = const BorderRadius.vertical(
            top: Radius.circular(radiusValue),
          );
        } else if (isPreviousChorus && isNextChorus) {
          borderRadius = BorderRadius.zero;
        } else if (isPreviousChorus && !isNextChorus) {
          borderRadius = const BorderRadius.vertical(
            bottom: Radius.circular(radiusValue),
          );
        } else {
          borderRadius = const BorderRadius.all(Radius.circular(radiusValue));
        }

        EdgeInsets padding;
        const double fullPadding = 16.0;
        const double halfPadding = 8.0;

        if (!isPreviousChorus && isNextChorus) {
          padding = const EdgeInsets.only(
            left: fullPadding,
            top: fullPadding,
            right: fullPadding,
            bottom: halfPadding,
          );
        } else if (isPreviousChorus && isNextChorus) {
          padding = const EdgeInsets.symmetric(
            horizontal: fullPadding,
            vertical: halfPadding,
          );
        } else if (isPreviousChorus && !isNextChorus) {
          padding = const EdgeInsets.only(
            left: fullPadding,
            top: halfPadding,
            right: fullPadding,
            bottom: fullPadding,
          );
        } else {
          padding = const EdgeInsets.all(fullPadding);
        }

        return Container(
          padding: padding,
          margin: EdgeInsets.only(left: 8, right: 8),
          decoration: BoxDecoration(
            color: AppColors.chorusColor,
            borderRadius: borderRadius,
          ),
          child: _buildVerseTextColumn(context, currentBlock.versesList),
        );
      },
    );
  }

  Widget _buildVerseTextColumn(BuildContext context, List<String> lines) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: lines.map((line) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Text(
            line,
            style: AppFonts.defaultFont(
              color: AppColors.grey10,
              fontSize: context.sizeOf.width > ResponsivityUtil.smallDeviceWidth
                  ? 16
                  : 14,
            ),
          ),
        );
      }).toList(),
    );
  }
}
