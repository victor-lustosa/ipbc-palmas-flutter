import 'package:flutter/material.dart';

import '../../../shared/configs/app_configs.dart';
import '../../../shared/layout/top-bar/title_top_bar_widget.dart';

class OfferingView extends StatelessWidget {
  const OfferingView({super.key});

  final String cnpj = "38.136.701/0001-25";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TitleTopBarWidget(title: "Dízimos e Ofertas"),
            Padding(
              padding: const EdgeInsets.only(top: 24.0, left: 16),
              child: Text(
                "Dados bancários",
                style: AppFonts.title3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24.0, left: 16),
              child: Text(
                "Pix",
                style: AppFonts.headline,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.45, left: 16, right: 16),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
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
                        child: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.content_copy_rounded)),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24.0, left: 16),
              child: Text(
                "Igreja Presbiteriana de Palmas",
                style: AppFonts.body2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24.0, left: 16),
              child: Text(
                "Banco do Brasil",
                style: AppFonts.body2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24),
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
    );
  }
}
