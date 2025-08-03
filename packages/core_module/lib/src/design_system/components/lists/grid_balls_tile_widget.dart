import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class GridBallsTileWidget extends StatelessWidget {
  const GridBallsTileWidget({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 16,
          width: 10,
          child: GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 2,
            crossAxisSpacing: 2,
            padding: EdgeInsets.zero,
            children: List.generate(6, (index) {
              return Container(
                height: 2.5,
                width: 2.5,
                decoration: BoxDecoration(
                  color: AppColors.cardGreen,
                  borderRadius: BorderRadius.circular(50),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
