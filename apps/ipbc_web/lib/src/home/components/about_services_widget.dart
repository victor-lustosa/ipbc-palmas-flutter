import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class AboutServicesWidget extends StatefulWidget {
  const AboutServicesWidget({super.key});

  @override
  State<AboutServicesWidget> createState() => _AboutServicesWidgetState();
}

class _AboutServicesWidgetState extends State<AboutServicesWidget> {
  List labelsRightBloc = [
    'Culto de Domingo',
    'Culto de Oração',
    'EBD',
    'Pequeno Grupo'
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 241, vertical: 100),
      decoration: const BoxDecoration(color: Color(0xffffffff)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 79),
            child: Text(
              'Programação',
              style: AppFonts.defaultFont(
                fontSize: 46,
                fontWeight: FontWeight.w600,
                color: const Color(0xff242426),
              ),
            ),
          ),
          SizedBox(
            height: 694,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 80),
                  width: 260,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(bottom: 40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            leftBloc('Cultos de Domingo', '9h e 19h, na IPBC Palmas'),
                            const SizedBox(height: 40),
                            leftBloc('Cultos de Oração', 'Quartas às 19h na IPBC Palmas'),
                            const SizedBox(height: 40),
                            leftBloc('EBD', 'Todos os domingos às 9h, na IPBC Palmas'),
                            const SizedBox(height: 40),
                            Container(
                              margin: const EdgeInsets.only(bottom: 16),
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
                                    text: 'Terças e quartas em diversas localidades. ',
                                    style: AppFonts.defaultFont(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xff545456),
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Entrar em contato para mais informações.',
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
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: SizedBox(
                    width: 618,
                    height: 1362,
                    child: ListView.separated(
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(height: 24);
                      },
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: labelsRightBloc.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (_, index) {
                        return rightBloc('', labelsRightBloc[index]);
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

  Widget rightBloc(String image, String title) => Container(
      padding: const EdgeInsets.only(left: 16, top: 270, right: 16, bottom: 16),
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

  Widget leftBloc(String title, String subtitle) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 16),
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
      ],
    );
}
