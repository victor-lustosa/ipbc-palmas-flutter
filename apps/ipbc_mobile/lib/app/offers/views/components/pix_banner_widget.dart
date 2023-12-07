import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

import 'banner_base_widget.dart';

class PixBannerWidget extends StatefulWidget {
  const PixBannerWidget({super.key});

  @override
  State<PixBannerWidget> createState() => _PixBannerWidgetState();
}

class _PixBannerWidgetState extends State<PixBannerWidget> with ClipboardMixin {
  final GlobalKey<TooltipState> tooltipKeyPix = GlobalKey<TooltipState>();

  final String cnpj = "38.136.701/0001-25";

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
          BaseBannerWidget(),
          Container(
            margin:
                const EdgeInsets.only(top: 2, left: 5, right: 5, bottom: 24),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 35, right: 18),
                  child: Text(
                    'CNPJ',
                    style: AppFonts.defaultFont(
                      color: AppColors.secondaryGreen2,
                      fontSize: 13,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Text(
                          cnpj,
                          style: AppFonts.defaultFont(
                            color: AppColors.white,
                            fontSize: 20,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 3),
                          child: Tooltip(
                            message: "copiado!",
                            textStyle: AppFonts.body(
                              color: AppColors.grey10,
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                            ),
                            key: tooltipKeyPix,
                            triggerMode: TooltipTriggerMode.manual,
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
                                copy(cnpj);
                                tooltipKeyPix.currentState
                                    ?.ensureTooltipVisible();
                              },
                              icon: const Icon(
                                Icons.content_copy_rounded,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
