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
  late double vWidth;
  bool isPressed = false;
  final double lgSize = 1200;

  @override
  Widget build(BuildContext context) {
    vWidth = context.sizeOf.width;

    if (vWidth < 600) {
      return mobile();
    } else if (vWidth < 915) {
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
                logo(),
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
                                scrollPage(vWidth > lgSize
                                    ? 1575
                                    : 1656,
                                );
                              },
                            ),
                            TabButtonsWidget(
                              label: 'Programação',
                              action: () {
                                scrollPage(vWidth > lgSize
                                    ? 2175
                                    : 2534,
                                );
                              },
                            ),
                            TabButtonsWidget(
                              label: 'Aplicativo',
                              action: () {
                                scrollPage(vWidth > lgSize
                                    ? 3232
                                    : 3560,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      contactButton(
                        width: 259,
                        height: 49,
                        leftMargin: 16,
                        label: 'Entrar em contato',
                        position: vWidth > lgSize
                            ? 3965
                            : 4230,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 0.4,
            decoration: const BoxDecoration(color: AppColors.grey5),
          )
        ],
      );

  tablet() => Column(
        children: [
          Container(
            margin: upperMargin(value: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                logo(),
                contactButton(
                  width: 259,
                  height: 49,
                  position: 4185,
                  leftMargin: 16,
                  label: 'Entrar em contato',
                )
              ],
            ),
          ),
          Container(
            height: 0.4,
            decoration: const BoxDecoration(color: AppColors.grey5),
          )
        ],
      );

  mobile() => Column(
        children: [
          Container(
            margin: upperMargin(value: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                logo(),
                contactButton(
                  width: 166,
                  height: 49,
                  leftMargin: 8,
                  label: 'Contato',
                  position: vWidth > ResponsivityUtil.smallDeviceWidth
                      ? 4160
                      : 4330,
                )
              ],
            ),
          ),
          Container(
            height: 0.4,
            decoration: const BoxDecoration(color: AppColors.grey5),
          )
        ],
      );

  logo() => const Image(
        width: 100,
        image: AssetImage(AppImages.logo),
      );

  contactButton(
          {required double position,
          required double width,
          required double height,
          required double leftMargin,
          required String label}) =>
      SizedBox(
        width: width,
        height: height,
        child: ButtonWidget(
          foregroundColor:
              isPressed
                  ? AppColors.grey12
                  : AppColors.white,
          shadowColor: AppColors.grey6,
          backgroundColor:
              isPressed
                  ? AppColors.highlightGreen
                  : AppColors.darkGreen,
          action: () => _onPressed(position: position),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(label),
              Container(
                margin: EdgeInsets.only(left: leftMargin),
                child: Image.asset(
                  isPressed
                      ? AppIcons.contactIconDarkGreen
                      : AppIcons.contactIcon,
                  width: 24,
                  height: 24,
                ),
              ),
            ],
          ),
        ),
      );

  upperMargin({required double value}) => EdgeInsets.only(
        top: value,
        bottom: value,
        left: TopBarResponsive.leftWidth(vWidth),
        right: TopBarResponsive.rightWidth(vWidth),
      );

  scrollPage(double position) => setState(
        () {
          Modular.get<HomeViewModel>().scrollController.animateTo(
            position,
            curve: Curves.easeInOutQuint,
            duration: const Duration(milliseconds: 1500),
          );
        },
      );

  _onPressed({required double position}) async {
    Future.delayed(
      Duration.zero,
      () async => setState(
        () {
          isPressed = true;
        },
      )
    );
    Future.delayed(
      const Duration(milliseconds: 500),
      () async {
        scrollPage(position);
      },
    );
    Future.delayed(
      const Duration(milliseconds: 900),
      () async {
        setState(
          () {
            isPressed = false;
          },
        );
      },
    );
  }
}
