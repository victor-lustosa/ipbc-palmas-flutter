/*import 'package:flutter/material.dart';

class ContactFormWidget extends StatefulWidget {
  const ContactFormWidget({super.key});

  @override
  State<ContactFormWidget> createState() => _ContactFormWidgetState();
}

class _ContactFormWidgetState extends State<ContactFormWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // contactform8PR (1:58)
          padding:
              EdgeInsets.fromLTRB(470 * fem, 100 * fem, 470 * fem, 100 * fem),
          width: double.infinity,
          height: 689 * fem,
          decoration: BoxDecoration(
            color: Color(0xfff3f3f3),
          ),
          child: Container(
            // container4ns (1:59)
            width: double.infinity,
            height: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  // sectiontitleRdR (1:60)
                  margin: EdgeInsets.fromLTRB(
                      35 * fem, 0 * fem, 35 * fem, 40 * fem),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // h2getintouchAb1 (1:61)
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 0 * fem, 15 * fem),
                        child: Text(
                          'Entre em contato',
                          textAlign: TextAlign.center,
                          style: SafeGoogleFont(
                            'Inter',
                            fontSize: 32 * ffem,
                            fontWeight: FontWeight.w700,
                            height: 1.2000000477 * ffem / fem,
                            color: Color(0xff242426),
                          ),
                        ),
                      ),
                      Text(
                        // envieseupedidodeoraosolicitaoo (1:62)
                        'Envie seu pedido de oração, solicitação ou dúvida.',
                        textAlign: TextAlign.center,
                        style: SafeGoogleFont(
                          'Inter',
                          fontSize: 18 * ffem,
                          fontWeight: FontWeight.w400,
                          height: 1.5 * ffem / fem,
                          color: Color(0xff545456),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  // formots (1:64)
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // inputwrapperwVH (1:65)
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              // formblocklabeluBD (1:66)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 0 * fem, 8 * fem),
                              child: Text(
                                'Nome',
                                style: SafeGoogleFont(
                                  'Inter',
                                  fontSize: 14 * ffem,
                                  fontWeight: FontWeight.w400,
                                  height: 1.5 * ffem / fem,
                                  color: Color(0xff545456),
                                ),
                              ),
                            ),
                            Container(
                              // formtextinput2md (1:67)
                              padding: EdgeInsets.fromLTRB(
                                  12 * fem, 11 * fem, 12 * fem, 11 * fem),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Color(0xffffffff),
                                borderRadius: BorderRadius.circular(12 * fem),
                              ),
                              child: Text(
                                'Seu nome completo',
                                style: SafeGoogleFont(
                                  'Inter',
                                  fontSize: 14 * ffem,
                                  fontWeight: FontWeight.w500,
                                  height: 1.4000000272 * ffem / fem,
                                  color: Color(0xff979797),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16 * fem,
                      ),
                      Container(
                        // inputwrapperWB1 (1:69)
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              // formblocklabelFuH (1:70)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 0 * fem, 8 * fem),
                              child: Text(
                                'Email',
                                style: SafeGoogleFont(
                                  'Inter',
                                  fontSize: 14 * ffem,
                                  fontWeight: FontWeight.w400,
                                  height: 1.5 * ffem / fem,
                                  color: Color(0xff545456),
                                ),
                              ),
                            ),
                            Container(
                              // formtextinputAmM (1:71)
                              padding: EdgeInsets.fromLTRB(
                                  12 * fem, 12 * fem, 12 * fem, 10 * fem),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Color(0xffffffff),
                                borderRadius: BorderRadius.circular(12 * fem),
                              ),
                              child: Text(
                                'me@company.com',
                                style: SafeGoogleFont(
                                  'Inter',
                                  fontSize: 14 * ffem,
                                  fontWeight: FontWeight.w500,
                                  height: 1.4000000272 * ffem / fem,
                                  color: Color(0xff979797),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16 * fem,
                      ),
                      Container(
                        // textareawrapperzEb (1:73)
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              // formblocklabelwvX (1:74)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 0 * fem, 8 * fem),
                              child: Text(
                                'Mensagem',
                                style: SafeGoogleFont(
                                  'Inter',
                                  fontSize: 14 * ffem,
                                  fontWeight: FontWeight.w400,
                                  height: 1.5 * ffem / fem,
                                  color: Color(0xff545456),
                                ),
                              ),
                            ),
                            Container(
                              // formtextareaspB (1:75)
                              padding: EdgeInsets.fromLTRB(
                                  12 * fem, 12 * fem, 12 * fem, 12 * fem),
                              width: double.infinity,
                              height: 100 * fem,
                              decoration: BoxDecoration(
                                color: Color(0xffffffff),
                                borderRadius: BorderRadius.circular(12 * fem),
                              ),
                              child: Text(
                                'Sua mensagem...',
                                style: SafeGoogleFont(
                                  'Inter',
                                  fontSize: 14 * ffem,
                                  fontWeight: FontWeight.w500,
                                  height: 1.4000000272 * ffem / fem,
                                  color: Color(0xff979797),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16 * fem,
                      ),
                      Container(
                        // formbuttonB4B (1:77)
                        width: double.infinity,
                        height: 49 * fem,
                        decoration: BoxDecoration(
                          color: Color(0xff005b40),
                          borderRadius: BorderRadius.circular(20 * fem),
                        ),
                        child: Center(
                          child: Text(
                            'Enviar',
                            style: SafeGoogleFont(
                              'Inter',
                              fontSize: 18 * ffem,
                              fontWeight: FontWeight.w500,
                              height: 1.3999999364 * ffem / fem,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
*/