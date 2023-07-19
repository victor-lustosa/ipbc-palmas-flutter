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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 116,bottom: 154),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 141,
                  height: 36,
                  child: Image.asset(
                    'assets/page-1/images/logo-T3V.png',
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: 600,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            'Endereço',
                            style: AppFonts.defaultFont(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xffffffff),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'CEP',
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
                            'Nome e telefone',
                            style: AppFonts.defaultFont(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xffffffff),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Nome e telefone',
                            style: AppFonts.defaultFont(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xffffffff),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Nome e telefone',
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
                            'Quarta às 19h',
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
            margin: const EdgeInsets.only(left: 39.67,bottom: 31),
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
