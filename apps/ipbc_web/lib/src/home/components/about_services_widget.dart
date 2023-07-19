/*import 'package:flutter/material.dart';

class AboutServicesWidget extends StatefulWidget {
  const AboutServicesWidget({super.key});

  @override
  State<AboutServicesWidget> createState() => _AboutServicesWidgetState();
}

class _AboutServicesWidgetState extends State<AboutServicesWidget> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // galleryscrollcLf (1:136)
          padding:
              EdgeInsets.fromLTRB(241 * fem, 100 * fem, 241 * fem, 100 * fem),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xffffffff),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                // h1titlecopygoesherebeawesomeWw (1:167)
                margin:
                EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 79 * fem),
                child: Text(
                  'Programação',
                  style: SafeGoogleFont(
                    'Inter',
                    fontSize: 46 * ffem,
                    fontWeight: FontWeight.w600,
                    height: 1.2000000166 * ffem / fem,
                    color: Color(0xff242426),
                  ),
                ),
              ),
              Container(
                // columns2vB (1:137)
                width: double.infinity,
                height: 694 * fem,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      // contentmcs (1:139)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 80 * fem, 0 * fem),
                      width: 260 * fem,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // autogroup5saxWaT (Ly1rFmJJ6cLUqjUGSy5saX)
                            padding: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 0 * fem, 40 * fem),
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  // frame23aP (1:169)
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        // cultosdedomingoQfq (1:140)
                                        margin: EdgeInsets.fromLTRB(0 * fem,
                                            0 * fem, 0 * fem, 16 * fem),
                                        child: Text(
                                          'Cultos de Domingo',
                                          style: SafeGoogleFont(
                                            'Inter',
                                            fontSize: 24 * ffem,
                                            fontWeight: FontWeight.w500,
                                            height: 1.5 * ffem / fem,
                                            color: Color(0xff242426),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        // he19hnaipbcpalmasgdM (1:168)
                                        '9h e 19h, na IPBC Palmas',
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
                                SizedBox(
                                  height: 40 * fem,
                                ),
                                Container(
                                  // frame3oxs (1:171)
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        // cultosdeoraoNm5 (1:172)
                                        margin: EdgeInsets.fromLTRB(0 * fem,
                                            0 * fem, 0 * fem, 16 * fem),
                                        child: Text(
                                          'Cultos de Oração',
                                          style: SafeGoogleFont(
                                            'Inter',
                                            fontSize: 24 * ffem,
                                            fontWeight: FontWeight.w500,
                                            height: 1.5 * ffem / fem,
                                            color: Color(0xff242426),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        // quartass19hnaipbcpalmash2f (1:174)
                                        constraints: BoxConstraints(
                                          maxWidth: 200 * fem,
                                        ),
                                        child: Text(
                                          'Quartas às 19h na IPBC Palmas',
                                          style: SafeGoogleFont(
                                            'Inter',
                                            fontSize: 18 * ffem,
                                            fontWeight: FontWeight.w400,
                                            height: 1.5 * ffem / fem,
                                            color: Color(0xff545456),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 40 * fem,
                                ),
                                Container(
                                  // frame4kmd (1:175)
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        // ebdvAK (1:176)
                                        margin: EdgeInsets.fromLTRB(0 * fem,
                                            0 * fem, 0 * fem, 16 * fem),
                                        child: Text(
                                          'EBD',
                                          style: SafeGoogleFont(
                                            'Inter',
                                            fontSize: 24 * ffem,
                                            fontWeight: FontWeight.w500,
                                            height: 1.5 * ffem / fem,
                                            color: Color(0xff242426),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        // todososdomingoss9hnaipbcpalmas (1:178)
                                        constraints: BoxConstraints(
                                          maxWidth: 249 * fem,
                                        ),
                                        child: Text(
                                          'Todos os domingos às 9h, na IPBC Palmas',
                                          style: SafeGoogleFont(
                                            'Inter',
                                            fontSize: 18 * ffem,
                                            fontWeight: FontWeight.w400,
                                            height: 1.5 * ffem / fem,
                                            color: Color(0xff545456),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            // frame5LE3 (1:179)
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  // pequenosgruposJAs (1:180)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 0 * fem, 16 * fem),
                                  child: Text(
                                    'Pequenos Grupos',
                                    style: SafeGoogleFont(
                                      'Inter',
                                      fontSize: 24 * ffem,
                                      fontWeight: FontWeight.w500,
                                      height: 1.5 * ffem / fem,
                                      color: Color(0xff242426),
                                    ),
                                  ),
                                ),
                                Container(
                                  // terasequartasemdiversaslocalid (1:182)
                                  constraints: BoxConstraints(
                                    maxWidth: 260 * fem,
                                  ),
                                  child: RichText(
                                    text: TextSpan(
                                      style: SafeGoogleFont(
                                        'Inter',
                                        fontSize: 18 * ffem,
                                        fontWeight: FontWeight.w400,
                                        height: 1.5 * ffem / fem,
                                        color: Color(0xff545456),
                                      ),
                                      children: [
                                        TextSpan(
                                          text:
                                              'Terças e quartas em diversas localidades. ',
                                          style: SafeGoogleFont(
                                            'Inter',
                                            fontSize: 18 * ffem,
                                            fontWeight: FontWeight.w400,
                                            height: 1.5 * ffem / fem,
                                            color: Color(0xff545456),
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                              'Entrar em contato para mais informações',
                                          style: SafeGoogleFont(
                                            'Inter',
                                            fontSize: 18 * ffem,
                                            fontWeight: FontWeight.w400,
                                            height: 1.5 * ffem / fem,
                                            decoration:
                                                TextDecoration.underline,
                                            color: Color(0xff545456),
                                            decorationColor: Color(0xff545456),
                                          ),
                                        ),
                                        TextSpan(
                                          text: '.',
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
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // columnpis (1:145)
                      width: 618 * fem,
                      height: double.infinity,
                      child: Container(
                        // contentnQo (1:146)
                        width: double.infinity,
                        height: 1362 * fem,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // imageukK (1:148)
                              padding: EdgeInsets.fromLTRB(
                                  16 * fem, 270 * fem, 16 * fem, 16 * fem),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Color(0x33005b40),
                                borderRadius: BorderRadius.circular(20 * fem),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                    'assets/page-1/images/image-bg-zQ7.png',
                                  ),
                                ),
                              ),
                              child: Text(
                                'Culto de Domingo',
                                style: SafeGoogleFont(
                                  'Inter',
                                  fontSize: 24 * ffem,
                                  fontWeight: FontWeight.w700,
                                  height: 1.5 * ffem / fem,
                                  color: Color(0xffffffff),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 24 * fem,
                            ),
                            Container(
                              // imageZZy (1:151)
                              padding: EdgeInsets.fromLTRB(
                                  16 * fem, 272 * fem, 16 * fem, 16 * fem),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Color(0x33005b40),
                                borderRadius: BorderRadius.circular(20 * fem),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                    'assets/page-1/images/image-bg-xtF.png',
                                  ),
                                ),
                              ),
                              child: Text(
                                'Culto de Oração',
                                style: SafeGoogleFont(
                                  'Inter',
                                  fontSize: 24 * ffem,
                                  fontWeight: FontWeight.w700,
                                  height: 1.5 * ffem / fem,
                                  color: Color(0xffffffff),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 24 * fem,
                            ),
                            Container(
                              // image1KV (1:154)
                              padding: EdgeInsets.fromLTRB(
                                  16 * fem, 270 * fem, 16 * fem, 16 * fem),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Color(0x33005b40),
                                borderRadius: BorderRadius.circular(20 * fem),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                    'assets/page-1/images/image-bg-5Lb.png',
                                  ),
                                ),
                              ),
                              child: Text(
                                'EBD',
                                style: SafeGoogleFont(
                                  'Inter',
                                  fontSize: 24 * ffem,
                                  fontWeight: FontWeight.w700,
                                  height: 1.5 * ffem / fem,
                                  color: Color(0xffffffff),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 24 * fem,
                            ),
                            Container(
                              // image31H (1:157)
                              padding: EdgeInsets.fromLTRB(
                                  16 * fem, 270 * fem, 16 * fem, 16 * fem),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Color(0x33005b40),
                                borderRadius: BorderRadius.circular(20 * fem),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                    'assets/page-1/images/image-bg-rmd.png',
                                  ),
                                ),
                              ),
                              child: Text(
                                'Pequeno Grupo',
                                style: SafeGoogleFont(
                                  'Inter',
                                  fontSize: 24 * ffem,
                                  fontWeight: FontWeight.w700,
                                  height: 1.5 * ffem / fem,
                                  color: Color(0xffffffff),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
*/