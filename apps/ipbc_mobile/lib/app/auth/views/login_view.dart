import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';
/*padronizar cores de acordo com Design system
* vincular tela ao splash screm
*
*
*
*  */
class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container (
                width: 74,
                  height: 43,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      AppImages.logoLoginImage,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
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
                    SizedBox(
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
                  ],
                ),
              ),
              Container(
                width: 343,
                height: 48,
                child: Stack(
                  children: [
                    Container(
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
                    SizedBox(
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
                  ],
                ),
              ),
              Container(
                width: 343,
                height: 48,
                child: Stack(
                  children: [
                    Container(
                      width: 343,
                      height: 48,
                      decoration: ShapeDecoration(
                        color: Color(0xFF005B40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                    SizedBox(
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
                  ],
                ),
              ),
              Text(
                'Insira seu email ',
                style: TextStyle(
                  color: Color(0xFF444446),
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  height: 21.40,
                ),
              ),
              Text(
                'Insira sua senha',
                style: TextStyle(
                  color: Color(0xFF444446),
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  height: 21.40,
                ),
              ),
              Container(
                width: 343,
                height: 48,
                child: Stack(
                  children: [
                    Container(
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
                    Container(
                      width: 251,
                      height: 30,
                      child: Stack(
                        children: [
                          Text(
                            'Fazer cadastro com o Google',
                            style: TextStyle(
                              color: Color(0xFF363638),
                              fontSize: 15,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Container(
                            width: 30,
                            height: 30,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage("https://via.placeholder.com/30x30"),
                                fit: BoxFit.fill,
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
                width: 343,
                height: 48,
                child: Stack(
                  children: [
                    Container(
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
                    Container(
                      width: 272,
                      height: 32,
                      child: Stack(
                        children: [
                          Text(
                            'Fazer cadastro com o Facebook',
                            style: TextStyle(
                              color: Color(0xFF363638),
                              fontSize: 15,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Container(
                            width: 32,
                            height: 32,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage("https://via.placeholder.com/32x32"),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                'ou',
                style: TextStyle(
                  color: Color(0xFF545456),
                  fontSize: 17,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  height: 21.40,
                ),
              ),
              Text(
                'Fazer login',
                style: TextStyle(
                  color: Color(0xFF363638),
                  fontSize: 22,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),
              Container(
                width: 32,
                height: 32,
                child: Stack(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(color: Color(0xFFD9D9D9)),
                    ),
                  ],
                ),
              ),
              Container(
                width: 375,
                height: 812,
                child: Stack(
                  children: [
                    Opacity(
                      opacity: 0,
                      child: Container(
                        width: 375,
                        height: 34,
                        decoration: BoxDecoration(color: Color(0xFFDCDCE6)),
                      ),
                    ),
                    Container(
                      width: 135,
                      height: 5,
                      decoration: ShapeDecoration(
                        color: Color(0xFFDCDCE6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                    Container(
                      width: 66.66,
                      height: 11.34,
                      child: Stack(
                        children: [
                          Container(
                            width: 24.33,
                            height: 11.33,
                            child: const Stack(children: [

                            ]),
                          ),
                          Container(
                            width: 15.27,
                            height: 10.97,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage("https://via.placeholder.com/15x11"),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Container(
                            width: 17,
                            height: 10.67,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage("https://via.placeholder.com/17x11"),
                                fit: BoxFit.fill,
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
    );
  }
}