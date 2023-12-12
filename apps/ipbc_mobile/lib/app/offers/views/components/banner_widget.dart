import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

import '../../controller/banner_controller.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});
  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> with ClipboardMixin {
  final GlobalKey<TooltipState> tooltipKeyPix = GlobalKey<TooltipState>();
  final GlobalKey<TooltipState> tooltipKeyAg = GlobalKey<TooltipState>();
  final GlobalKey<TooltipState> tooltipKeyCc = GlobalKey<TooltipState>();
  late bool isSmallD;
  final String ag = "3962-4";
  final String cc = "7293-1";
  final String cnpj = "38.136.701/0001-25";

  final controller = Modular.get<BannerController>();

  @override
  Widget build(BuildContext context) {
    isSmallD = ResponsivityUtil.isSmallDevice(context);
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (context, value, child) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.cardGreen,
            borderRadius: BorderRadius.circular(12.36),
          ),
          child: Column(
            children: [
              baseBanner(),
              value ? pixBanner() : tedBanner(),
            ],
          ),
        );
      },
    );
  }

  baseBanner() => Container(
        margin: EdgeInsets.only(
          left: isSmallD ? 24 : 35,
          right: isSmallD ? 20 : 24,
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(
                top: 24,
                bottom: 16,
              ),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: isSmallD ? 15 : 24),
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
            Container(
              height: 1,
              width: context.mediaQuery.size.width * .78,
              color: AppColors.secondaryGreen2,
            ),
          ],
        ),
      );

  pixBanner() => Container(
        margin: EdgeInsets.only(
          left: isSmallD ? 24 : 35,
          right: isSmallD ? 20 : 24,
          bottom: 24,
          top: 16,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: isSmallD ? 15 : 24),
                  child: Text(
                    'CNPJ',
                    style: AppFonts.defaultFont(
                      color: AppColors.secondaryGreen2,
                      fontSize: 13,
                    ),
                  ),
                ),
                Text(
                  cnpj,
                  style: AppFonts.defaultFont(
                    color: AppColors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            iconTooltip(
              margin: EdgeInsets.zero,
              value: cnpj,
              key: tooltipKeyPix,
            ),
          ],
        ),
      );

  tedBanner() => Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 24, top: 16),
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
            margin: const EdgeInsets.only(top: 16, bottom: 24, right: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Ag $ag",
                  style: AppFonts.defaultFont(
                    color: AppColors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                iconTooltip(
                  margin: const EdgeInsets.only(right: 16, left: 8),
                  value: ag,
                  key: tooltipKeyAg,
                ),
                Text(
                  "C/c $cc",
                  style: AppFonts.defaultFont(
                    color: AppColors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                iconTooltip(
                  margin: const EdgeInsets.only(left: 8),
                  value: cc,
                  key: tooltipKeyCc,
                ),
              ],
            ),
          ),
        ],
      );

  iconTooltip(
          {required String value,
          required EdgeInsetsGeometry margin,
          required GlobalKey<TooltipState> key}) =>
      Container(
        width: 20,
        height: 20,
        margin: margin,
        child: Tooltip(
          message: "copiado!",
          textStyle: AppFonts.body(
            color: AppColors.grey10,
            fontWeight: FontWeight.w500,
            fontSize: 13,
          ),
          key: key,
          triggerMode: TooltipTriggerMode.tap,
          showDuration: const Duration(seconds: 1),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: AppColors.highlightGreen,
          ),
          preferBelow: false,
          child: IconButtonWidget(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            action: () {
              copy(value);
              key.currentState?.ensureTooltipVisible();
            },
            color: AppColors.white,
            androidIcon: Icons.content_copy_rounded,
            iOSIcon: Icons.content_copy_rounded,
          ),
        ),
      );
}
