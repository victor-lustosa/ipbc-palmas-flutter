/*import 'package:flutter/material.dart';

class AppStoresWidget extends StatefulWidget {
  const AppStoresWidget({super.key});

  @override
  State<AppStoresWidget> createState() => _AppStoresWidgetState();
}

class _AppStoresWidgetState extends State<AppStoresWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // heroheadingrightv55 (1:46)
          padding: EdgeInsets.fromLTRB(120 * fem, 100 * fem, 0 * fem, 0 * fem),
          width: double.infinity,
          height: 734 * fem,
          decoration: BoxDecoration(
            color: Color(0xff005b40),
          ),
          child: Container(
            // container2du (1:47)
            width: 1426.62 * fem,
            height: 699.81 * fem,
            child: Stack(
              children: [
                Positioned(
                  // telasipbcapp1yZ9 (1:219)
                  left: 352.341003418 * fem,
                  top: 15 * fem,
                  child: Align(
                    child: SizedBox(
                      width: 1074.28 * fem,
                      height: 684.81 * fem,
                      child: Image.asset(
                        'assets/page-1/images/telas-ipbc-app-1-2jh.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  // columnG2T (1:51)
                  left: 0 * fem,
                  top: 0 * fem,
                  child: Container(
                    width: 571 * fem,
                    height: 253 * fem,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          // contento2P (1:52)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 40 * fem),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                // baixeoipbcappKmR (1:53)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 0 * fem, 23 * fem),
                                child: Text(
                                  'Baixe o IPBC App',
                                  style: SafeGoogleFont(
                                    'Inter',
                                    fontSize: 46 * ffem,
                                    fontWeight: FontWeight.w600,
                                    height: 1.2000000166 * ffem / fem,
                                    color: Color(0xffffffff),
                                  ),
                                ),
                              ),
                              Container(
                                // acompanhealiturgiadoscultosasl (1:54)
                                constraints: BoxConstraints(
                                  maxWidth: 569 * fem,
                                ),
                                child: Text(
                                  'Acompanhe a liturgia dos cultos, as letras das músicas cantadas e eem breve, comunicações, eventos e mensagens pregadas.',
                                  style: SafeGoogleFont(
                                    'Inter',
                                    fontSize: 18 * ffem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.5 * ffem / fem,
                                    color: Color(0xccffffff),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          // frame1Xcb (1:111)
                          width: double.infinity,
                          height: 80 * fem,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                // button4cX (1:56)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 24 * fem, 0 * fem),
                                padding: EdgeInsets.fromLTRB(
                                    32 * fem, 24 * fem, 32 * fem, 24 * fem),
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  color: Color(0xff242426),
                                  borderRadius: BorderRadius.circular(20 * fem),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      // appleiconmWw (1:216)
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 0 * fem, 16 * fem, 0 * fem),
                                      width: 32 * fem,
                                      height: 32 * fem,
                                      child: Image.asset(
                                        'assets/page-1/images/apple-icon-kto.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Container(
                                      // baixenaappstoregdu (1:57)
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 1 * fem, 0 * fem, 0 * fem),
                                      child: Text(
                                        'Baixe na App Store',
                                        style: SafeGoogleFont(
                                          'Inter',
                                          fontSize: 18 * ffem,
                                          fontWeight: FontWeight.w500,
                                          height: 1.3999999364 * ffem / fem,
                                          color: Color(0xffffffff),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                // buttonQpo (1:109)
                                padding: EdgeInsets.fromLTRB(
                                    32 * fem, 24 * fem, 32 * fem, 24 * fem),
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  color: Color(0xff242426),
                                  borderRadius: BorderRadius.circular(20 * fem),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      // playstoreicon9XV (1:217)
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 0 * fem, 16 * fem, 0 * fem),
                                      width: 32 * fem,
                                      height: 32 * fem,
                                      child: Image.asset(
                                        'assets/page-1/images/playstore-icon-zqd.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Container(
                                      // baixenaplaystoreV5Z (1:110)
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 1 * fem, 0 * fem, 0 * fem),
                                      child: Text(
                                        'Baixe na PlayStore',
                                        style: SafeGoogleFont(
                                          'Inter',
                                          fontSize: 18 * ffem,
                                          fontWeight: FontWeight.w500,
                                          height: 1.3999999364 * ffem / fem,
                                          color: Color(0xffffffff),
                                        ),
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
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
*/