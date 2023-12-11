import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

import 'banner_base_widget.dart';

class TedBannerWidget extends StatefulWidget {
  const TedBannerWidget({super.key});

  @override
  State<TedBannerWidget> createState() => _TedBannerWidgetState();
}

class _TedBannerWidgetState extends State<TedBannerWidget> with ClipboardMixin {
  final GlobalKey<TooltipState> tooltipKeyAg = GlobalKey<TooltipState>();
  final GlobalKey<TooltipState> tooltipKeyCc = GlobalKey<TooltipState>();

  final String ag = "3962-4";
  final String cc = "7293-1";

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
          const BaseBannerWidget(),
          Container(
            margin: const EdgeInsets.only(top: 16, left: 35, right: 5),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 11),
                  child: Text(
                    'BANCO',
                    style: AppFonts.defaultFont(
                      color: AppColors.secondaryGreen2,
                      fontSize: 13,
                    ),
                  ),
                ),
                Text(
                  'Banco do Brasil',
                  style: AppFonts.defaultFont(
                    color: AppColors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 16, left: 98, bottom: 24),
            child: Row(
              children: [
                Text(
                  "Ag $ag",
                  style: AppFonts.defaultFont(
                      color: AppColors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 16),
                  child: Tooltip(
                    message: "copiado!",
                    textStyle: AppFonts.body(
                      color: AppColors.grey10,
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                    key: tooltipKeyAg,
                    triggerMode: TooltipTriggerMode.tap,
                    showDuration: const Duration(seconds: 1),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.highlightGreen,
                    ),
                    preferBelow: false,
                    child: IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () {
                        copy(ag);
                        tooltipKeyAg.currentState?.ensureTooltipVisible();
                      },
                      icon: const Icon(
                        Icons.content_copy_rounded,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
                Text(
                  "C/c $cc",
                  style: AppFonts.defaultFont(
                      color: AppColors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
                Tooltip(
                  message: "copiado!",
                  textStyle: AppFonts.body(
                    color: AppColors.grey10,
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                  key: tooltipKeyCc,
                  showDuration: const Duration(seconds: 1),
                  triggerMode: TooltipTriggerMode.tap,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: AppColors.highlightGreen,
                  ),
                  preferBelow: false,
                  child: IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () {
                      copy(cc);
                      tooltipKeyCc.currentState?.ensureTooltipVisible();
                    },
                    icon: const Icon(
                      Icons.content_copy_rounded,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
