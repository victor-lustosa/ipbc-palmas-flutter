import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';
import '../../home/view-models/home_view_model.dart';

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
      width: context.mediaQuery.size.width,
      height: context.mediaQuery.size.height * 0.85,
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
              style: AppFonts.defaultFont(
                color: AppColors.grey12,
                fontWeight: FontWeight.w500,
                fontSize: 17,
              ),
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
                    style: AppFonts.defaultFont(
                      color: Colors.black,
                      fontSize: 13,
                    ),
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
              style: AppFonts.defaultFont(
                color: AppColors.grey12,
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          SizedBox(
            height: 48,
            width: 186,
            child: ElevatedButtonWidget(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              action: () {
                final homeViewModel = Modular.get<HomeViewModel>();
                homeViewModel.jumpToPage(widget.index);
              },
              backgroundColor: AppColors.darkGreen,
              child: Text("RECARREGAR",style: AppFonts.defaultFont(
                color: AppColors.white,
              ),),
            ),
          )
        ],
      ),
    );
  }
}
