import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';
import 'package:ipbc_palmas/app/offers/controller/banner_controller.dart';
import 'package:ipbc_palmas/app/offers/views/components/card_widget.dart';

import '../../../layout/top-bar/title_top_bar_widget.dart';
import 'components/pix_banner_widget.dart';
import 'components/ted_banner_widget.dart';

class OffersView extends StatefulWidget {
  const OffersView({super.key});

  @override
  State<OffersView> createState() => _OffersViewState();
}

class _OffersViewState extends State<OffersView> with ClipboardMixin {
  final GlobalKey<TooltipState> tooltipKey = GlobalKey<TooltipState>();

  final setPixorTed = BannerController();

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const TitleTopBarWidget(title: "Dízimos e Ofertas"),
              SizedBox(
                width: context.mediaQuery.size.width * .92,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ValueListenableBuilder(
                        valueListenable: setPixorTed,
                        builder: (context, value, child) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ValueListenableBuilder(
                                valueListenable: setPixorTed,
                                builder: (context, value, child) {
                                  return Container(
                                    margin: const EdgeInsets.only(
                                      top: 32,
                                      left: 33.5,
                                      right: 33.5,
                                      bottom: 24,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ElevatedButtonWidget(
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            side: BorderSide(
                                              color: value
                                                  ? AppColors.tabGreen
                                                  : AppColors.grey4,
                                            ),
                                          ),
                                          backgroundColor: value
                                              ? AppColors.tabGreen
                                              : AppColors.white,
                                          action: () {
                                            setPixorTed.setPix();
                                          },
                                          child: Text(
                                            'Pix',
                                            style: TextStyle(
                                                color: value
                                                    ? AppColors.white
                                                    : AppColors.grey4),
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        ElevatedButtonWidget(
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            side: BorderSide(
                                              color: value
                                                  ? AppColors.grey4
                                                  : AppColors.tabGreen,
                                            ),
                                          ),
                                          backgroundColor: value
                                              ? AppColors.white
                                              : AppColors.tabGreen,
                                          action: () {
                                            setPixorTed.setTed();
                                          },
                                          child: Text(
                                            'Transferência bancária',
                                            style: TextStyle(
                                                color: value
                                                    ? AppColors.grey4
                                                    : AppColors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          );
                        }),
                    Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: Center(
                        child: Text(
                          'Copie e cole o código pix em seu app bancário.',
                          style: AppFonts.defaultFont(
                              color: AppColors.grey10,
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    ValueListenableBuilder(
                        valueListenable: setPixorTed,
                        builder: (context, value, child) {
                          return value
                              ? const PixBannerWidget()
                              : const TedBannerWidget();
                        }),
                    Container(
                      margin: const EdgeInsets.only(top: 26, bottom: 8),
                      child: defaultLabel("Entenda como você pode ajudar!"),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.grey3),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12)),
                      ),
                      child: const CardOffer(
                        title: 'Dízimo',
                        imagePath: AppIcons.dizimo,
                        description: 'Não é necessário acrescentar código.',
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          left: BorderSide(color: AppColors.grey3),
                          bottom: BorderSide(color: AppColors.grey3),
                          right: BorderSide(color: AppColors.grey3),
                        ),
                      ),
                      child: const CardOffer(
                        title: 'Ofertas',
                        price: 'R\$ 0,77 ',
                        imagePath: AppIcons.ofertas,
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          left: BorderSide(color: AppColors.grey3),
                          right: BorderSide(color: AppColors.grey3),
                        ),
                      ),
                      child: const CardOffer(
                        title: 'Missões',
                        price: 'R\$ 0,33 ',
                        imagePath: AppIcons.missao,
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(color: AppColors.grey3),
                            left: BorderSide(color: AppColors.grey3),
                            bottom: BorderSide(color: AppColors.grey3),
                            right: BorderSide(color: AppColors.grey3),
                          ),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12))),
                      child: const CardOffer(
                        title: 'Oferta para compra do lote',
                        price: 'R\$ 0,28 ',
                        imagePath: AppIcons.lote,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 12,
                  bottom: 32,
                ),
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
    );
  }

  Widget defaultLabel(String label) {
    return Text(
      label,
      style: AppFonts.body(
        color: AppColors.grey9,
        fontWeight: FontWeight.w500,
        fontSize: 17,
      ),
    );
  }
}
