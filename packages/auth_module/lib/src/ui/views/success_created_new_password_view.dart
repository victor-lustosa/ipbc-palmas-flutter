import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class CreatedNewPasswordsuccess extends StatelessWidget {
  const CreatedNewPasswordsuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 162, left: 15, right: 15),
              child: Column(
                children: [
                  const Image(image: AssetImage(AppImages.lock)),
                  const SizedBox(
                    height: 25,
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
                ],
              ),
            ),
            const SizedBox(
              height: 376,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: ElevatedButtonWidget(
                action: () {
                  Modular.to.navigate('/auth');
                },
                backgroundColor: AppColors.darkGreen,
                shadowColor: AppColors.grey0,
                foregroundColor: AppColors.white,
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Row(
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
            ),
          ],
        ),
      ),
    );
  }
}
