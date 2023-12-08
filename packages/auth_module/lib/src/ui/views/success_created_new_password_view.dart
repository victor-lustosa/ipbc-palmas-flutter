import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class CreatedNewPasswordsuccess extends StatelessWidget {
  const CreatedNewPasswordsuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: context.mediaQuery.size.width,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 162, bottom: 25),
                  child: const Image(image: AssetImage(AppImages.lock)),
              ),
              Text(
                'Nova senha',
                style: AppFonts.defaultFont(
                  color: AppColors.grey10,
                  fontSize: 22,
                ),
              ),
              Text(
                'Criada com sucesso!',
                style: AppFonts.defaultFont(
                  color: AppColors.grey10,
                  fontSize: 22,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 376, left: 16.0, right: 16.0),
                child: ElevatedButtonWidget(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  fixedSize: const Size(343, 48),
                  action: () {
                    Modular.to.navigate('/auth');
                  },
                  backgroundColor: AppColors.darkGreen,
                  shadowColor: AppColors.grey0,
                  foregroundColor: AppColors.white,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.arrow_back_ios_new),
                      Text(
                        "Continuar para o login",
                      ),
                      Icon(Icons.arrow_back),
                    ],
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