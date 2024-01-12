import 'package:auth_module/src/ui/components/x_modal.dart';
import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

import '../components/circle_modal.dart';
import '../components/email_field.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController emailController = TextEditingController();

  static const String emailMock = "victor@gmail.com";
  String emailTyped = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(
              left: 16,
              right: 16,
            ),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(
                    top: 108.11,
                    bottom: 53.89,
                  ),
                  child: Text(
                    "Redefinir senha",
                    style: AppFonts.defaultFont(
                        color: AppColors.grey10,
                        fontSize: 22,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "Insira seu e-mail ou telefone",
                    style: AppFonts.defaultFont(
                        color: AppColors.grey8,
                        fontSize: 13,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 8, bottom: 8),
                    child: Column(
                      children: [
                        CustomEmailField(
                          onChanged: (value) {
                            setState(() {});
                          },
                          textLabel: 'Email',
                          borderSideColor: emailController.text.isEmpty
                              ? AppColors.grey8
                              : (emailMock == emailController.text
                                  ? AppColors.disableButton
                                  : AppColors.delete),
                          controller: emailController,
                          iconPath: emailMock == emailController.text
                              ? AppIcons.emailSuccess
                              : AppIcons.emailNotValid,
                        ),
                      ],
                    )),
                Container(
                  margin: const EdgeInsets.only(
                    top: 40,
                  ),
                  child: ElevatedButtonWidget(
                    action: () {
                      if (emailMock == emailController.text) {
                        // Lógica para o caso em que o email corresponde
                      } else {
                        _showErrorDialog();
                      }
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    fixedSize: const Size(364, 48),
                    backgroundColor: emailMock == emailController.text
                        ? AppColors.darkGreen
                        : AppColors.disableButton,
                    shadowColor: AppColors.grey0,
                    foregroundColor: AppColors.white,
                    child: const Text(
                      "Enviar",
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showErrorDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) {
        return Stack(
          children: [
            Positioned(
              bottom: 40, // Defina para altura do modal
              left: 13,
              right: 13,
              child: AlertDialog(
                clipBehavior: Clip.none,
                insetPadding: const EdgeInsets.all(3),
                contentPadding: const EdgeInsets.all(20),
                backgroundColor: AppColors.redModal,
                content: IntrinsicHeight(
                  child: Row(
                    children: [
                      const CircleWithX(),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'E-mail inválido!',
                              style: AppFonts.defaultFont(
                                fontSize: 16,
                                color: AppColors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              'Por favor, verifique seu e-mail e tente novamente.',
                              style: AppFonts.defaultFont(
                                fontSize: 12,
                                color: AppColors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: ButtonStyle(
                                alignment: Alignment.topRight,
                                padding:
                                    MaterialStateProperty.all(EdgeInsets.zero)),
                            child: const Xmodal(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
