import 'package:flutter/material.dart';

import '../../../shared/configs/app_configs.dart';
import '../../../shared/layout/top-bar/title_top_bar_widget.dart';
import '../../../shared/mixins/clipboard_mixin.dart';

class OfferingView extends StatefulWidget {
  const OfferingView({super.key});

  @override
  State<OfferingView> createState() => _OfferingViewState();
}

class _OfferingViewState extends State<OfferingView> with ClipboardMixin {
  final String cnpj = "38.136.701/0001-25";

  final GlobalKey<TooltipState> tooltipkey = GlobalKey<TooltipState>();

  @override
  Widget build(BuildContext context) {
    print(tooltipkey.currentState);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TitleTopBarWidget(title: "Dízimos e Ofertas"),
              Padding(
                padding: const EdgeInsets.only(top: 42.0, left: 16),
                child: Text(
                  "Dados bancários",
                  style: AppFonts.title3,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25.0, left: 16),
                child: Text(
                  "Pix",
                  style: AppFonts.headline,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 16,
                  bottom: 6,
                  left: 16,
                  right: 16,
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(16),
                  ),
                  child: Container(
                    height: 50,
                    width: 720,
                    decoration:
                        const BoxDecoration(color: AppColors.secondLightGrey),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Text(
                            "CNPJ: $cnpj",
                            style: AppFonts.botao,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 3),
                          child: Tooltip(
                              message: "copiado!",
                              textStyle: AppFonts.body2,
                              key: tooltipkey,
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
                                    tooltipkey.currentState
                                        ?.ensureTooltipVisible();
                                  },
                                  icon:
                                      const Icon(Icons.content_copy_rounded))),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 26.0, left: 16),
                child: Text(
                  "Igreja Presbiteriana de Palmas",
                  style: AppFonts.body2,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0, left: 16),
                child: Text(
                  "Banco do Brasil",
                  style: AppFonts.body2,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        "Ag: 3962-4",
                        style: AppFonts.body2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: Text(
                        "C/c: 7293-1",
                        style: AppFonts.body2,
                      ),
                    ),
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
