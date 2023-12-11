import 'package:auth_module/src/ui/view_models/login_view_model.dart';
import 'package:core_module/core_module.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../components/auth_fields.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginViewModel viewModel = Modular.get<LoginViewModel>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 60, bottom: 32),
                child: const Image(
                  image: AssetImage(
                    AppImages.logoLoginImage,
                  ),
                  fit: BoxFit.cover,
                  width: 166,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 24),
                child: Text('Fazer login',
                    style: AppFonts.defaultFont(
                      color: AppColors.grey10,
                      fontSize: 22,
                    )),
              ),
              AuthFields(controller: viewModel),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 8, right: 15.5),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            style: AppFonts.defaultFont(
                              color: AppColors.darkGreen,
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                              decorationColor: AppColors.darkGreen,
                            ),
                            text: "Esqueceu a senha? ",
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 40,
                  bottom: 24,
                  left: 16,
                  right: 16,
                ),
                height: 48,
                width: context.mediaQuery.size.width,
                child: ElevatedButtonWidget(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  action: () async {
                    var message = await viewModel.logIn();
                    if (message != '') {
                      Future.delayed(
                        Duration.zero,
                        () async {
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Center(
                                  child: Text(
                                    message,
                                    style: const TextStyle(fontSize: 17),
                                  ),
                                ),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                      );
                    }
                  },
                  backgroundColor: AppColors.darkGreen,
                  shadowColor: AppColors.grey0,
                  foregroundColor: AppColors.white,
                  child: const Text(
                    "ENTRAR",
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(border: Border.all(color: AppColors.loginLineDecoration)),

                    width: 159,
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 16,
                  left: 16,
                  right: 16,
                ),
                height: 48,
                width: context.mediaQuery.size.width,
                child: ElevatedButtonWidget(
                  backgroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  shadowColor: AppColors.grey0,
                  foregroundColor: AppColors.grey10,
                  textStyle: AppFonts.defaultFont(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                  action: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 12),
                        child: Image.asset(
                          AppIcons.googleIcon,
                          width: 30,
                          height: 30,
                        ),
                      ),
                      const Text(
                        "Fazer login com o Google",
                      ),
                      const SizedBox(
                        width: 18,
                      )
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 12,
                  left: 16,
                  bottom: 25,
                  right: 16,
                ),
                height: 48,
                width: context.mediaQuery.size.width,
                child: ElevatedButtonWidget(
                  backgroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  foregroundColor: AppColors.grey10,
                  textStyle: AppFonts.defaultFont(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                  action: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 12),
                        child: Image.asset(
                          AppIcons.faceIcon,
                          width: 32,
                          height: 32,
                        ),
                      ),
                      const Text(
                        "Fazer login com o Facebook",
                      ),
                    ],
                  ),
                ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Não possui conta?  ",
                      style: AppFonts.defaultFont(
                        color: AppColors.grey9,
                        fontSize: 15,
                      ),
                    ),
                    TextSpan(
                      style: AppFonts.defaultFont(
                        color: AppColors.darkGreen,
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.darkGreen,
                      ),
                      text: "Criar conta ",
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => setState(
                              () {
                                viewModel.toCreateAccount();
                              },
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
