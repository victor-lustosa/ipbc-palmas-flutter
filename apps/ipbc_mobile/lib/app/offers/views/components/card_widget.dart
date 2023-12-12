import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class CardOffer extends StatelessWidget {
  final String title;
  final String? price;
  final String imagePath;
  final String? description;

  const CardOffer(
      {Key? key,
      required this.title,
      required this.imagePath,
      this.description,
      this.price})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 17, bottom: 17),
      child: Row(
        children: [
          Image.asset(
            imagePath,
            height: 30,
            width: 24,
            color: AppColors.primaryGreen,
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 14,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  softWrap: true,
                  style: AppFonts.defaultFont(
                    color: AppColors.grey12,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                price != null ? withPrice() : withoutPrice()
              ],
            ),
          )
        ],
      ),
    );
  }

  withPrice() => RichText(
        textAlign: TextAlign.start,
        text: TextSpan(
          style: AppFonts.defaultFont(
            color: AppColors.grey12,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          children: [
            const TextSpan(
              text: 'Acrescentar ',
            ),
            TextSpan(
              text: price!,
              style: const TextStyle(
                color: AppColors.cardGreen,
                fontWeight: FontWeight.bold,
              ),
            ),
            const TextSpan(
              text: 'ao final da sua \ntransferência.',
            ),
          ],
        ),
      );
  withoutPrice() => Text(
        softWrap: true,
        description!,
        style: AppFonts.defaultFont(
          color: AppColors.grey12,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      );
}
