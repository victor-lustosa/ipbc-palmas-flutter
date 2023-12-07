import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';
import 'package:ipbc_palmas/app/offers/controller/banner_controller.dart';

class BaseBannerWidget extends StatefulWidget {
  const BaseBannerWidget({super.key});

  @override
  State<BaseBannerWidget> createState() => _BaseBannerWidgetState();
}

class _BaseBannerWidgetState extends State<BaseBannerWidget> {
  final pixOrTed = BannerController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 378,
      decoration: BoxDecoration(
        color: AppColors.cardGreen,
        borderRadius: BorderRadius.circular(12.36),
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 36, bottom: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 35, right: 24),
                  child: Text(
                    'PARA',
                    style: AppFonts.defaultFont(
                      color: AppColors.secondaryGreen2,
                      fontSize: 13,
                    ),
                  ),
                ),
                Text(
                  'IGREJA PRESBITERIANA DE PALMAS',
                  style: AppFonts.defaultFont(
                    color: AppColors.white,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            height: 20,
            thickness: 0.5,
            indent: 35,
            endIndent: 50,
            color: AppColors.secondaryGreen2,
          ),
        ],
      ),
    );
  }
}
