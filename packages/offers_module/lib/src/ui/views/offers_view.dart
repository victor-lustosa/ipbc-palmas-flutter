import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../controller/banner_controller.dart';
import 'components/banner_widget.dart';
import 'components/card_widget.dart';

class OffersView extends StatefulWidget {
  const OffersView({super.key});

  @override
  State<OffersView> createState() => _OffersViewState();
}

class _OffersViewState extends State<OffersView> with ClipboardMixin {
  final GlobalKey<TooltipState> tooltipKey = GlobalKey<TooltipState>();
  late BorderRadiusGeometry? borderRadius;
  late BoxBorder? border;
  final controller = Modular.get<BannerController>();
  final List<CardOffer> cardsList = const [
    CardOffer(
      title: 'Dízimo',
      imagePath: AppIcons.dizimo,
      description: 'Não é necessário acrescentar código.',
    ),
    CardOffer(
      title: 'Ofertas',
      price: 'R\$ 0,77 ',
      imagePath: AppIcons.ofertas,
    ),
    CardOffer(title: 'Missões', price: 'R\$ 0,33 ', imagePath: AppIcons.missao),
    CardOffer(
      title: 'Oferta para compra do lote',
      price: 'R\$ 0,28 ',
      imagePath: AppIcons.lote,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const TitleTopBarWidget(title: "Dízimos e Ofertas"),
                Container(
                  width: context.sizeOf.width,
                  margin: const EdgeInsets.only(left: 16, right: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 32, bottom: 24),
                        child: AnimatedBuilder(
                          animation: controller,
                          builder: (context, child) {
                            return Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(right: 16),
                                  child: ButtonWidget(
                                    elevation: 0,
                                    adaptiveButtonType: controller.isPix
                                        ? AdaptiveButtonType.elevated
                                        : AdaptiveButtonType.outlined,
                                    fixedSize: Size(73, 30),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    sideColor: controller.isPix
                                        ? null
                                        : AppColors.grey4,
                                    backgroundColor: controller.isPix
                                        ? AppColors.tabGreen
                                        : AppColors.white,
                                    action: () {
                                      controller.setPix();
                                    },
                                    child: buttonLabel('Pix', controller.isPix),
                                  ),
                                ),
                                ButtonWidget(
                                  elevation: 0,
                                  adaptiveButtonType: controller.isPix
                                      ? AdaptiveButtonType.outlined
                                      : AdaptiveButtonType.elevated,
                                  fixedSize: Size(219, 30),
                                  sideColor: controller.isPix
                                      ? AppColors.grey4
                                      : null,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    side: BorderSide(
                                      color: controller.isPix
                                          ? AppColors.grey4
                                          : AppColors.tabGreen,
                                    ),
                                  ),
                                  backgroundColor: controller.isPix
                                      ? AppColors.white
                                      : AppColors.tabGreen,
                                  action: () {
                                    controller.setTed();
                                  },
                                  child: buttonLabel(
                                    'Transferência bancária',
                                    !controller.isPix,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          'Copie e cole o código pix em seu app bancário.',
                          style: AppFonts.defaultFont(
                            color: AppColors.grey10,
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const BannerWidget(),
                      Container(
                        margin: const EdgeInsets.only(top: 26, bottom: 8),
                        child: Text(
                          "Entenda como você pode ajudar!",
                          style: AppFonts.body(
                            color: AppColors.grey9,
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                          ),
                        ),
                      ),
                      Column(
                        children: List<Widget>.generate(cardsList.length, (
                          index,
                        ) {
                          calculateTheEdge(index);
                          return Container(
                            decoration: BoxDecoration(
                              border: border,
                              borderRadius: borderRadius,
                            ),
                            child: cardsList[index],
                          );
                        }),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 12, bottom: 32),
                  child: Text(
                    'O comprovante deve ser depositado \n no gazofilácio.',
                    style: AppFonts.defaultFont(
                      color: AppColors.grey7,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  calculateTheEdge(int index) {
    border = Border(
      top: index == 0
          ? const BorderSide(color: AppColors.grey3)
          : BorderSide.none,
      left: const BorderSide(color: AppColors.grey3),
      right: const BorderSide(color: AppColors.grey3),
      bottom: const BorderSide(color: AppColors.grey3),
    );
    if (index == 0) {
      borderRadius = const BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
      );
    } else if (index != 0 && (index + 1) != cardsList.length) {
      borderRadius = const BorderRadius.only();
    } else if ((index + 1) == cardsList.length) {
      borderRadius = const BorderRadius.only(
        bottomLeft: Radius.circular(12),
        bottomRight: Radius.circular(12),
      );
    }
  }

  buttonLabel(String label, bool isPix) => Text(
    label,
    style: TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w500,
      color: isPix ? AppColors.white : AppColors.grey4,
    ),
  );
}
