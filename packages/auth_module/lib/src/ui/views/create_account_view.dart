import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

import '../components/auth_fields_widget.dart';

class CreateAccountView extends StatefulWidget {
  const CreateAccountView({super.key});

  @override
  State<CreateAccountView> createState() => _CreateAccountViewState();
}
//trocar os icon buttons e o text button de apps, e ajeitar as fontes do site
class _CreateAccountViewState extends State<CreateAccountView> {
  final LoginViewModel viewModel = Modular.get<LoginViewModel>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20, top: 20),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => Modular.to.pop(context),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  color: AppColors.darkGreen,
                  icon: const Icon(
                    size: 30,
                    Icons.arrow_back_rounded,
                  ),
                ),
              ),
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 60, bottom: 32),
                    child: const Image(
                      image: AssetImage(
                        AppImages.logoLoginImage,
                      ),
                      fit: BoxFit.cover,
                      width: 74,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 24),
                    child: Text('Criar conta',
                        style: AppFonts.defaultFont(
                          color: AppColors.grey10,
                          fontSize: 22,
                        )),
                  ),
                  const AuthFieldsWidget(),
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
                        viewModel.createAccount();
                        Future.delayed(
                          Duration.zero,
                              () async {
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Center(
                                    child: Text(
                                      'Conta criada com sucesso',
                                      style: TextStyle(fontSize: 17),
                                    ),
                                  ),
                                  backgroundColor: AppColors.darkGreen,
                                ),
                              );
                            }
                          },
                        );
                      },
                      backgroundColor: AppColors.darkGreen,
                      shadowColor: AppColors.grey0,
                      foregroundColor: AppColors.white,
                      child: const Text(
                        "CADASTRAR",
                      ),
                    ),
                  ),
                  Text(
                    "ou",
                    style: AppFonts.defaultFont(
                      color: AppColors.grey9,
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                    ),
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
                      top: 16,
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
