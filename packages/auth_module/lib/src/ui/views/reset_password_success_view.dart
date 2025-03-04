import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class ResetPasswordSuccessView extends StatelessWidget {
  const ResetPasswordSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: context.sizeOf.width,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 162, bottom: 25),
                child: const Image(image: AssetImage(AppImages.lock)),
              ),
              Text(
                textAlign: TextAlign.center,
                'Nova senha',
                style: AppFonts.defaultFont(
                  color: AppColors.grey10,
                  fontSize: 22,
                ),
              ),
              Text(
                textAlign: TextAlign.center,
                'criada com sucesso!',
                style: AppFonts.defaultFont(
                  color: AppColors.grey10,
                  fontSize: 22,
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: context.sizeOf.height * .37,
                  left: 16.0,
                  right: 16.0,
                ),
                child: ButtonWidget(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  fixedSize: Size(context.sizeOf.width, 48),
                  action: () {
                    navigate(AppRoutes.authRoute + AppRoutes.loginRoute);
                  },
                  backgroundColor: AppColors.darkGreen,
                  shadowColor: AppColors.grey0,
                  foregroundColor: AppColors.white,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text("Continuar para o login")],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
