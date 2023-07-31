import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';
import '../../../home/view_models/home_view_model.dart';
import '../../components/tab_buttons_widget.dart';

class TopBarWidget extends StatefulWidget {
  const TopBarWidget({super.key, required this.homeViewModel});

  final HomeViewModel homeViewModel;

  @override
  State<TopBarWidget> createState() => _TopBarWidgetState();
}

class _TopBarWidgetState extends State<TopBarWidget> {
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(
            top: 24,
            left: 110,
            right: 134,
            bottom: 24,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Image(
                width: 100,
                image: AssetImage(
                  AppImages.logo,
                ),
              ),
              Flexible(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TabButtonsWidget(
                        label: 'Localização',
                        action: () {
                          scrollPage(1544);
                        }),
                    TabButtonsWidget(
                        label: 'Programação',
                        action: () {
                          scrollPage(2192);
                        }),
                    TabButtonsWidget(
                        label: 'Aplicativo',
                        action: () {
                          scrollPage(3252);
                        }),
                    SizedBox(
                      width: 259,
                      height: 49,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: isPressed
                              ? const Color(0xff242426)
                              : AppColors.white,
                          shadowColor: AppColors.grey6,
                          backgroundColor: isPressed
                              ? const Color(0xFF00E8A2)
                              : AppColors.darkGreen,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          textStyle: AppFonts.defaultFont(fontSize: 18),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Entrar em contato'),
                              Container(
                                margin: const EdgeInsets.only(left: 16),
                                child: Image.asset(
                                  isPressed
                                      ? AppIcons.darkGreenCallIcon
                                      : AppIcons.callIcon,
                                  width: 24,
                                  height: 24,
                                ),
                              ),
                            ],
                          ),
                        ),
                        onPressed: () {
                          Future.delayed(Duration.zero, () async {
                            setState(() {
                              isPressed = true;
                            });
                          });
                          Future.delayed(const Duration(milliseconds: 500),
                              () async {
                                scrollPage(3985);
                          });
                          Future.delayed(const Duration(milliseconds: 900),
                              () async {
                            setState(() {
                              isPressed = false;
                            });
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          decoration: const BoxDecoration(color: AppColors.grey5),
          height: 0.4,
        )
      ],
    );
  }

  scrollPage(double position) {
    setState(() {
      widget.homeViewModel.scrollViewController.animateTo(
          duration: const Duration(milliseconds: 1500),
          curve: Curves.easeInOutQuint,
          position);
    });
  }
}
