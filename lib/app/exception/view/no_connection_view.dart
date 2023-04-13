import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../../home/view-models/home_view_model.dart';
import '../../shared/configs/app_configs.dart';

class NoConnectionView extends StatefulWidget {
  const NoConnectionView({super.key, required this.index});
  final int index;
  @override
  State<NoConnectionView> createState() => _NoConnectionViewState();
}

class _NoConnectionViewState extends State<NoConnectionView> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height* 0.85,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
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
          Container(
            width: 226.31,
            margin: const EdgeInsets.only(top: 9.8, bottom: 59.8),
            child: Text(
              "Ops! Você está sem conexão com a internet!",
              style: AppFonts.titleNoConnection,
              textAlign: TextAlign.center,
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
                onPressed: () {
                final homeViewModel =  context.read<HomeViewModel>();
                homeViewModel.jumpToPage(widget.index);
                },
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
    );
  }
}
