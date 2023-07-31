import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class FooterWidget extends StatefulWidget {
  const FooterWidget({super.key});

  @override
  State<FooterWidget> createState() => _FooterWidgetState();
}

class _FooterWidgetState extends State<FooterWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Color(0xff242426)),
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(
              top: 116,
              bottom: 154,
              right: 40,
            ),
            width: 910,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 99.34,
                  child: Image.asset(
                    AppImages.footerLogo,
                  ),
                ),
                SizedBox(
                  width: 600,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            child: Text(
                              'Localização',
                              style: AppFonts.defaultFont(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xffffffff),
                              ),
                            ),
                          ),
                          Text(
                            'Q. Arse 23, Av.Ns 06, Ai 09',
                            style: AppFonts.defaultFont(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xffffffff),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'CEP: 77020-544',
                            style: AppFonts.defaultFont(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xffffffff),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Palmas/TO',
                            style: AppFonts.defaultFont(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xffffffff),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            child: Text(
                              'Contatos',
                              style: AppFonts.defaultFont(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xffffffff),
                              ),
                            ),
                          ),
                          Text(
                            'Secretaria da Igreja',
                            style: AppFonts.defaultFont(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xffffffff),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '+55 (63) 3213-2775',
                            style: AppFonts.defaultFont(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xffffffff),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '8h as 12h - 14h as 18h',
                            style: AppFonts.defaultFont(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xffffffff),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            child: Text(
                              'Cultos',
                              style: AppFonts.defaultFont(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xffffffff),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            child: Text(
                              'Domingo às 9h e 19h',
                              style: AppFonts.defaultFont(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xffffffff),
                              ),
                            ),
                          ),
                          Text(
                            'Sábado às 19h30',
                            style: AppFonts.defaultFont(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xffffffff),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 31),
            child: Text(
              'Copyright © 2023 Igreja Presbiteriana Central em Palmas/TO',
              textAlign: TextAlign.center,
              style: AppFonts.defaultFont(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: const Color(0xffffffff),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
