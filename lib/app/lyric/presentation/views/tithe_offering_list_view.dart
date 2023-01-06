import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../shared/components/back-button/back_button_widget.dart';
import '../../../shared/components/circle-avatar/circle_avatar_widget.dart';
import '../../../shared/configs/app_configs.dart';
import '../../../shared/layout/top-bar/title_top_bar_widget.dart';

class TitheOfferingListView extends StatelessWidget {
  const TitheOfferingListView({super.key});

  final String cnpj = "38.136.701/0001-25";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TitleTopBarWidget(title: "Dizimos e Ofertas"),
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: Align(
                alignment: const Alignment(-0.81, 0),
                child: Text(
                  "Dados bancários",
                  style: AppFonts.title3,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: Align(
                alignment: const Alignment(-0.875, 0),
                child: Text(
                  "Pix",
                  style: AppFonts.headline,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.45),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: Container(
                  height: 50,
                  width: 350,
                  decoration: BoxDecoration(color: AppColors.secondLightGrey),
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
              padding: const EdgeInsets.only(top: 24.0),
              child: Align(
                alignment: const Alignment(-0.70, 0),
                child: Text(
                  "Igreja Presbiteriana de Palmas",
                  style: AppFonts.body2,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: Align(
                alignment: const Alignment(-0.85, 0),
                child: Text(
                  "Banco do Brasil",
                  style: AppFonts.body2,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 24.0),
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
