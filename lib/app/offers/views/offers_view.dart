import 'package:flutter/material.dart';

import '../../configs/app_configs.dart';
import '../../shared/layout/top-bar/title_top_bar_widget.dart';
import '../../shared/mixins/clipboard_mixin.dart';

class OffersView extends StatefulWidget {
  const OffersView({super.key});

  @override
  State<OffersView> createState() => _OffersViewState();
}

class _OffersViewState extends State<OffersView> with ClipboardMixin {
  final String cnpj = "38.136.701/0001-25";

  final GlobalKey<TooltipState> tooltipKey = GlobalKey<TooltipState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const TitleTopBarWidget(title: "Dízimos e Ofertas"),
              SizedBox(
                width: MediaQuery.of(context).size.width * .92,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 42.0),
                      child: Text(
                        "Dados bancários",
                        style: AppFonts.title3,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 25.0, bottom: 16),
                      child: Text(
                        "Pix",
                        style: AppFonts.headline,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        bottom: 6,
                      ),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(16),
                        ),
                        child: Container(
                          decoration:
                          const BoxDecoration(color: AppColors.secondLightGrey),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 15),
                                child: Text(
                                  "CNPJ: $cnpj",
                                  style: AppFonts.cnpjLabel,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(right: 3),
                                child: Tooltip(
                                  message: "copiado!",
                                  textStyle: AppFonts.body2,
                                  key: tooltipKey,
                                  triggerMode: TooltipTriggerMode.manual,
                                  showDuration: const Duration(seconds: 1),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: AppColors.tooltipGreen,
                                  ),
                                  preferBelow: false,
                                  child: IconButton(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onPressed: () {
                                      copy(cnpj);
                                      tooltipKey.currentState?.ensureTooltipVisible();
                                    },
                                    icon: const Icon(Icons.content_copy_rounded),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 26.0),
                      child: Text(
                        "Igreja Presbiteriana de Palmas",
                        style: AppFonts.body2,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 15.0),
                      child: Text(
                        "Banco do Brasil",
                        style: AppFonts.body2,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 15),
                      child: Row(
                        children: [
                          Text(
                            "Ag: 3962-4",
                            style: AppFonts.body2,
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 9),
                            child: Text(
                              "C/c: 7293-1",
                              style: AppFonts.body2,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
