import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

import '../../../layout/top-bar/title_top_bar_widget.dart';

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
                      margin: const EdgeInsets.only(top: 42),
                      child: Text(
                        "Dados bancários",
                        style: AppFonts.defaultFont(
                          color: AppColors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 25, bottom: 16),
                      child: Text(
                        "Pix",
                        style: AppFonts.headline(),
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
                          decoration: const BoxDecoration(
                            color: AppColors.grey0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 15),
                                child: Text(
                                  "CNPJ: $cnpj",
                                  style: AppFonts.defaultFont(
                                    color: AppColors.grey10,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                  ),
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
                                  key: tooltipKey,
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
                                      tooltipKey.currentState?.ensureTooltipVisible();
                                    },
                                    icon: const Icon(
                                      Icons.content_copy_rounded,
                                      color: AppColors.tooltipIcon,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 26),
                      child: defaultLabel("Igreja Presbiteriana de Palmas")
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 15),
                      child: defaultLabel("Banco do Brasil")
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 15),
                      child: Row(
                        children: [
                          defaultLabel("Ag: 3962-4"),
                          Container(
                            margin: const EdgeInsets.only(left: 9),
                            child: defaultLabel( "C/c: 7293-1"),
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
 Widget defaultLabel(String label){
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
