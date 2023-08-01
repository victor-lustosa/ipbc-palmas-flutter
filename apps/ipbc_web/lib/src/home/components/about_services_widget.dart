import 'package:core_module/core_module.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../view_models/home_view_model.dart';

class AboutServices {
  AboutServices({required this.label, required this.imagePath});
  final String label;
  final String imagePath;
}

class AboutServicesWidget extends StatefulWidget {
  const AboutServicesWidget({super.key, required this.viewModel});

  final HomeViewModel viewModel;

  @override
  State<AboutServicesWidget> createState() => _AboutServicesWidgetState();
}

class _AboutServicesWidgetState extends State<AboutServicesWidget> {
  final List<AboutServices> labelsRightBloc = [
    AboutServices(label: 'Culto Solene', imagePath: AppImages.sundayEveningService),
    AboutServices(label: 'Culto de Jovens', imagePath: AppImages.saturdayService),
    AboutServices(label: 'Escola Bíblica Dominical', imagePath: AppImages.sundayMorningService),
    AboutServices(label: 'Pequeno Grupo', imagePath: AppImages.littleGroup),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Color(0xffffffff)),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 79, top: 100),
            child: Text(
              'Programação',
              style: AppFonts.defaultFont(
                fontSize: 46,
                fontWeight: FontWeight.w600,
                color: const Color(0xff242426),
              ),
            ),
          ),
          Container(
            height: 694,
            width: 963,
            margin: const EdgeInsets.only(bottom: 127),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  width: 260,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      cardTitle('Cultos Solenes', 'Domingo às 19h, na IPBC Palmas'),
                      cardTitle('Cultos de Jovens', 'Sábado às 19h30 na IPBC Palmas'),
                      cardTitle('Escola Bíblica Dominical', 'Domingo às 9h, na IPBC Palmas'),
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: Text(
                          'Pequenos Grupos',
                          style: AppFonts.defaultFont(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff242426),
                          ),
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          style: AppFonts.defaultFont(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff545456),
                          ),
                          children: [
                            TextSpan(
                              text: 'Durante a semana em diversas localidades. ',
                              style: AppFonts.defaultFont(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xff545456),
                              ),
                            ),
                            TextSpan(
                              text: 'Entrar em contato para mais informações.',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => setState(
                                      () {
                                        widget.viewModel.scrollViewController
                                            .animateTo(
                                          duration: const Duration(
                                              milliseconds: 1500),
                                          curve: Curves.easeInOutQuint,
                                          3985,
                                        );
                                      },
                                    ),
                              style: AppFonts.defaultFont(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                decoration: TextDecoration.underline,
                                color: const Color(0xff545456),
                                decorationColor: const Color(0xff545456),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: SizedBox(
                    width: 618,
                    height: 1333,
                    child: ListView.separated(
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(height: 24);
                      },
                      scrollDirection: Axis.vertical,
                      itemCount: labelsRightBloc.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (_, index) {
                        return cardImage(labelsRightBloc[index].imagePath,
                            labelsRightBloc[index].label);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget cardImage(String image, String title) => Container(
        padding: const EdgeInsets.only(
          left: 16,
          top: 270,
          right: 16,
          bottom: 16,
        ),
        decoration: BoxDecoration(
          color: const Color(0x33005b40),
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(image),
          ),
        ),
        child: Text(
          title,
          style: AppFonts.defaultFont(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: const Color(0xffffffff),
          ),
        ),
      );

  Widget cardTitle(String title, String subtitle) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: Text(
              title,
              style: AppFonts.defaultFont(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: const Color(0xff242426),
              ),
            ),
          ),
          Text(
            subtitle,
            style: AppFonts.defaultFont(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: const Color(0xff545456),
            ),
          ),
          const SizedBox(height: 40),
        ],
      );
}
