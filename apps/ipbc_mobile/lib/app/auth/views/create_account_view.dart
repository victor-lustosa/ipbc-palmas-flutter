import 'package:flutter/material.dart';
/*padronizar cores de acordo com Design system
* vincular tela ao splash screm
*
*
*
*  */
class LoginView extends StatefulWidget {
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: 375,
            height: 812,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(color: Colors.white),
            child: Stack(
              children: [
                Positioned(
                  left: 150,
                  top: 60,
                  child: Container(
                    width: 74,
                    height: 43,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage("https://via.placeholder.com/74x43"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 17,
                  top: 220,
                  child: Container(
                    width: 343,
                    height: 48,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                            width: 343,
                            height: 48,
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                  width: 0.50,
                                  strokeAlign: BorderSide.strokeAlignCenter,
                                  color: Color(0xFFEBEBEB),
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                        ),
                        const Positioned(
                          left: 16,
                          top: 17,
                          child: SizedBox(
                            width: 38,
                            height: 14.40,
                            child: Text(
                              'Email',
                              style: TextStyle(
                                color: Color(0xFFA2A2A2),
                                fontSize: 12,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 17,
                  top: 318,
                  child: Container(
                    width: 343,
                    height: 48,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                            width: 343,
                            height: 48,
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                  width: 0.50,
                                  strokeAlign: BorderSide.strokeAlignCenter,
                                  color: Color(0xFFEBEBEB),
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                        ),
                        const Positioned(
                          left: 16,
                          top: 16,
                          child: SizedBox(
                            width: 45,
                            height: 14.40,
                            child: Text(
                              'Senha',
                              style: TextStyle(
                                color: Color(0xFFA2A2A2),
                                fontSize: 12,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 16,
                  top: 406,
                  child: Container(
                    width: 343,
                    height: 48,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                            width: 343,
                            height: 48,
                            decoration: ShapeDecoration(
                              color: Color(0xFF005B40),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                        ),
                        const Positioned(
                          left: 114,
                          top: 14,
                          child: SizedBox(
                            width: 115,
                            height: 21,
                            child: Text(
                              'CADASTRAR',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                height: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Positioned(
                  left: 17,
                  top: 194,
                  child: Text(
                    'Insira seu email ',
                    style: TextStyle(
                      color: Color(0xFF444446),
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 21.40,
                    ),
                  ),
                ),
                const Positioned(
                  left: 17,
                  top: 292,
                  child: Text(
                    'Crie sua senha',
                    style: TextStyle(
                      color: Color(0xFF444446),
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 21.40,
                    ),
                  ),
                ),
                Positioned(
                  left: 16,
                  top: 528,
                  child: Container(
                    width: 343,
                    height: 48,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                            width: 343,
                            height: 48,
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              shadows: const [
                                BoxShadow(
                                  color: Color(0x19000000),
                                  blurRadius: 12,
                                  offset: Offset(0, 4),
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 33,
                          top: 9,
                          child: Container(
                            width: 251,
                            height: 30,
                            child: Stack(
                              children: [
                                const Positioned(
                                  left: 42,
                                  top: 6,
                                  child: Text(
                                    'Fazer cadastro com o Google',
                                    style: TextStyle(
                                      color: Color(0xFF363638),
                                      fontSize: 15,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 0,
                                  top: 0,
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage("https://via.placeholder.com/30x30"),
                                        fit: BoxFit.fill,
                                      ),
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
                ),
                Positioned(
                  left: 16,
                  top: 592,
                  child: Container(
                    width: 343,
                    height: 48,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                            width: 343,
                            height: 48,
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              shadows: const [
                                BoxShadow(
                                  color: Color(0x19000000),
                                  blurRadius: 12,
                                  offset: Offset(0, 4),
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 33,
                          top: 8,
                          child: Container(
                            width: 272,
                            height: 32,
                            child: Stack(
                              children: [
                                const Positioned(
                                  left: 44,
                                  top: 7,
                                  child: Text(
                                    'Fazer cadastro com o Facebook',
                                    style: TextStyle(
                                      color: Color(0xFF363638),
                                      fontSize: 15,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 0,
                                  top: 0,
                                  child: Container(
                                    width: 32,
                                    height: 32,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage("https://via.placeholder.com/32x32"),
                                        fit: BoxFit.fill,
                                      ),
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
                ),
                const Positioned(
                  left: 177,
                  top: 486,
                  child: Text(
                    'ou',
                    style: TextStyle(
                      color: Color(0xFF545456),
                      fontSize: 17,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      height: 21.40,
                    ),
                  ),
                ),
                const Positioned(
                  left: 130,
                  top: 143,
                  child: Text(
                    'Criar conta',
                    style: TextStyle(
                      color: Color(0xFF363638),
                      fontSize: 22,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Positioned(
                  left: 16,
                  top: 65.50,
                  child: Container(
                    width: 32,
                    height: 32,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(color: Color(0xFFD9D9D9)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 0,
                  child: Container(
                    width: 375,
                    height: 812,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 778,
                          child: Opacity(
                            opacity: 0,
                            child: Container(
                              width: 375,
                              height: 34,
                              decoration: BoxDecoration(color: Color(0xFFDCDCE6)),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 120,
                          top: 799,
                          child: Container(
                            width: 135,
                            height: 5,
                            decoration: ShapeDecoration(
                              color: Color(0xFFDCDCE6),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 293.67,
                          top: 19.33,
                          child: Container(
                            width: 66.66,
                            height: 11.34,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 42.33,
                                  top: 0,
                                  child: Container(
                                    width: 24.33,
                                    height: 11.33,
                                    child: const Stack(children: [

                                    ]),
                                  ),
                                ),
                                Positioned(
                                  left: 22.03,
                                  top: 0,
                                  child: Container(
                                    width: 15.27,
                                    height: 10.97,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage("https://via.placeholder.com/15x11"),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 0,
                                  top: 0.34,
                                  child: Container(
                                    width: 17,
                                    height: 10.67,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage("https://via.placeholder.com/17x11"),
                                        fit: BoxFit.fill,
                                      ),
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}