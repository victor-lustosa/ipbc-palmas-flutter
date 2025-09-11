import 'package:core_module/core_module.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../auth_module.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginStore _store = Modular.get<LoginStore>();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _store,
      builder: (_, state, child) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 28, left: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [BackButtonWidget(action: () => pop(context))],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 35, bottom: 32),
                    child: const Image(
                      image: AssetImage(AppImages.logoLoginImage),
                      fit: BoxFit.cover,
                      width: 166,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 24),
                    child: Text(
                      'Fazer login',
                      style: AppFonts.defaultFont(
                        color: AppColors.grey10,
                        fontSize: 22,
                      ),
                    ),
                  ),
                  TemplateFormWidget(
                    valueListenable: _store.isEmailValid,
                    controller: _store.emailController,
                    title: 'Insira seu email',
                    isValid: _store.isEmailValid.value,
                    errorText: _store.emailErrorText,
                    globalKey: _store.emailKey,
                    isPressed: _store.areFieldsLocked,
                    inputDecoration: fieldInputDecoration(
                      isValid: _store.isEmailValid.value,
                      hintText: 'Email',
                    ),
                    validator: (data) {
                      return _store.formValidation(
                        _store.emailValidation(data),
                        _store.isEmailValid,
                      );
                    },
                    defaultHintColor: _store.isEmailValid.value
                        ? AppColors.hintInputForm
                        : AppColors.delete,
                  ),
                  TemplateFormWidget(
                    controller: _store.passwordController,
                    titleMargin: EdgeInsets.only(top: 24),
                    title: 'Insira sua senha',
                    isValid: _store.isPasswordValid.value,
                    errorText: _store.passwordErrorText,
                    globalKey: _store.passwordKey,
                    isPressed: _store.areFieldsLocked,
                    obscure: _store.obscure,
                    inputDecoration: fieldInputDecoration(
                      isValid: _store.isPasswordValid.value,
                      hintText: 'Senha',
                      contentPadding: const EdgeInsets.only(left: 16, top: 9),
                      suffixIcon: HideIconWidget(isObscure: _store.obscure),
                    ),
                    validator: (data) {
                      return _store.formValidation(
                        !_store.isEmptyData(data),
                        _store.isPasswordValid,
                      );
                    },
                    defaultHintColor: AppColors.hintInputForm,
                  ),
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
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    if (!_store.isLoginPressed.value) {
                                      pushNamed(
                                        AppRoutes.authRoute +
                                            AppRoutes.resetPasswordRoute,
                                      );
                                    }
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  LoadingButtonWidget(
                    loadingWidth: 55,
                    isPressed: _store.isLoginPressed,
                    action: () async {
                      _store.loginValidate(context: context);
                    },
                    isValid:
                        _store.isEmailValid.value &&
                        _store.isPasswordValid.value,
                    label: "Entrar",
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.loginLineDecoration,
                          ),
                        ),
                        width: 159,
                      ),
                    ],
                  ),
                  LoadingButtonWidget(
                    decoration:  BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(15),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    loadingIndicatorColor: AppColors.darkGreen,
                    margin: const EdgeInsets.only(
                      top: 16,
                      left: 16,
                      right: 16,
                      bottom: 25,
                    ),
                    loadingWidth: 55,
                    textStyle: AppFonts.defaultFont(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                    overlayColor: Colors.transparent,
                    foregroundColor: AppColors.grey10,
                    backgroundColor: AppColors.white,
                    disableColor: AppColors.white,
                    isPressed: _store.isGoogleLoginPressed,
                    action: () {
                      _store.googleSignIn(context);
                    },
                    isValid: !_store.isGoogleLoginPressed.value,
                    child: AnimatedOpacity(
                      opacity: _store.isGoogleLoginPressed.value ? 0.0 : 1.0,
                      duration: const Duration(milliseconds: 400),
                      curve: const Interval(0.5, 1.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Visibility(
                            visible: !_store.isGoogleLoginPressed.value,
                            child: Container(
                              margin: const EdgeInsets.only(right: 12),
                              child: Image.asset(
                                AppIcons.googleIcon,
                                width: 30,
                                height: 30,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: !_store.isGoogleLoginPressed.value,
                            child: Flexible(
                              child: const Text("Fazer login com o Google"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  /*Container(
                    margin: const EdgeInsets.only(
                      top: 12,
                      left: 16,
                      bottom: 25,
                      right: 16,
                    ),
                    height: 48,
                    width: context.sizeOf.width,
                    child: ButtonWidget(
                      backgroundColor: AppColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      foregroundColor: AppColors.grey10,
                      textStyle: AppFonts.defaultFont(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                      action: () {
                        _store.signInWithFacebook(context);
                      },
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
                          const Text("Fazer login com o Facebook"),
                        ],
                      ),
                    ),
                  ),*/
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
                            ..onTap = () => setState(() {
                              if (!_store.isLoginPressed.value) {
                                navigate(
                                  AppRoutes.authRoute +
                                      AppRoutes.createAccountRoute,
                                );
                              }
                            }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
