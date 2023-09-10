import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';
import '../../src/home/view_models/home_view_model.dart';
import '../constraints/layout_responsive.dart';
import 'tab_button/tab_buttons_widget.dart';

class TopBarWidget extends StatefulWidget {
  const TopBarWidget({super.key});

  @override
  State<TopBarWidget> createState() => _TopBarWidgetState();
}

class _TopBarWidgetState extends State<TopBarWidget> {
  bool isPressed = false;
  final double lgSize = 1200;

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width < 600) {
      return mobile();
    } else if (MediaQuery.of(context).size.width < 915) {
      return tablet();
    } else {
      return web();
    }
  }

  web() => Column(
        children: [
          Container(
            margin: upperMargin(value: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                heroImage(),
                SizedBox(
                  width: 693,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 400,
                        margin: const EdgeInsets.only(right: 32),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TabButtonsWidget(
                              label: 'Localização',
                              action: () {
                                scrollPage(
                                    MediaQuery.of(context).size.width > lgSize
                                        ? 1575
                                        : 1656);
                              },
                            ),
                            TabButtonsWidget(
                              label: 'Programação',
                              action: () {
                                scrollPage(
                                    MediaQuery.of(context).size.width > lgSize
                                        ? 2175
                                        : 2534);
                              },
                            ),
                            TabButtonsWidget(
                              label: 'Aplicativo',
                              action: () {
                                scrollPage(
                                    MediaQuery.of(context).size.width > lgSize
                                        ? 3232
                                        : 3560);
                              },
                            ),
                          ],
                        ),
                      ),
                      contactButton(
                          position: MediaQuery.of(context).size.width > lgSize
                              ? 3965
                              : 4280)
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

  tablet() => Column(
        children: [
          Container(
            margin: upperMargin(value: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [heroImage(), contactButton(position: 4185)],
            ),
          ),
          Container(
            decoration: const BoxDecoration(color: AppColors.grey5),
            height: 0.4,
          )
        ],
      );

  mobile() => Column(
        children: [
          Container(
            margin: upperMargin(value: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [heroImage(), smallContactButton(position: 4250)],
            ),
          ),
          Container(
            decoration: const BoxDecoration(color: AppColors.grey5),
            height: 0.4,
          )
        ],
      );

  heroImage() => const Image(
        width: 100,
        image: AssetImage(
          AppImages.logo,
        ),
      );

  contactButton({required double position}) => SizedBox(
        width: 259,
        height: 49,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor:
                isPressed ? const Color(0xff242426) : AppColors.white,
            shadowColor: AppColors.grey6,
            backgroundColor:
                isPressed ? const Color(0xFF00E8A2) : AppColors.darkGreen,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            textStyle: AppFonts.defaultFont(fontSize: 18),
          ),
          onPressed: () => _onPressed(position: position),
          child: Center(
            child: SizedBox(
              width: 198,
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
          ),
        ),
      );

  smallContactButton({required double position}) => SizedBox(
        width: 88,
        height: 49,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor:
                isPressed ? const Color(0xff242426) : AppColors.white,
            shadowColor: AppColors.grey6,
            backgroundColor:
                isPressed ? const Color(0xFF00E8A2) : AppColors.darkGreen,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            textStyle: AppFonts.defaultFont(fontSize: 18),
          ),
          onPressed: () => _onPressed(position: position),
          child: Center(
            child: Image.asset(
              isPressed ? AppIcons.darkGreenCallIcon : AppIcons.callIcon,
              width: 24,
              height: 24,
            ),
          ),
        ),
      );

  upperMargin({required double value}) => EdgeInsets.only(
        top: value,
        left: TopBarResponsive.leftWidth(MediaQuery.of(context).size.width),
        right: TopBarResponsive.rightWidth(MediaQuery.of(context).size.width),
        bottom: value,
      );

  scrollPage(double position) => setState(() {
        Modular.get<HomeViewModel>().scrollViewController.animateTo(
            duration: const Duration(milliseconds: 1500),
            curve: Curves.easeInOutQuint,
            position);
      });

  _onPressed({required double position}) async {
    Future.delayed(
        Duration.zero,
        () async => setState(() {
              isPressed = true;
            }));
    Future.delayed(const Duration(milliseconds: 500), () async {
      scrollPage(position);
    });
    Future.delayed(const Duration(milliseconds: 900), () async {
      setState(() {
        isPressed = false;
      });
    });
  }
}