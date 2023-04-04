import 'dart:io';

import 'package:flutter/material.dart';
import '../../shared/configs/app_configs.dart';

class NoConnectionView<T> extends StatefulWidget {
  const NoConnectionView({super.key, required this.bloc});
  final dynamic bloc;
  @override
  State<NoConnectionView> createState() => _NoConnectionViewState();
}

class _NoConnectionViewState extends State<NoConnectionView> {
  final String cnpj = "38.136.701/0001-25";

  final GlobalKey<TooltipState> tooltipKey = GlobalKey<TooltipState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      AppImages.noConnectionImage,
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                width: 226.31,
                margin: const EdgeInsets.only(top: 9.8, bottom: 59.8),
                child: Text(
                  "Ops! Você está sem conexão com a internet!",
                  style: AppFonts.titleNoConnection,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Center(
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFEDEDED),
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                width: 74.8,
                height: 32.8,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 16.8,
                      height: 16.8,
                      margin: const EdgeInsets.only(right: 8),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            AppImages.wifiIconImage,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "Wi-fi",
                      style: AppFonts.wifiLabel,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15.09, bottom: 121.63),
              width: 198.26,
              child: Text(
                "Cheque sua conexão e tente novamente.",
                style: AppFonts.checkConnectionLabel,
                textAlign: TextAlign.center,
              ),
            ),
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              child: SizedBox(
                height: 48,
                width: 186,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      AppColors.darkGreen,
                    ),
                  ),
                  child: Text(
                    "RECARREGAR",
                    style: AppFonts.checkConnectionButtonLabel,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
