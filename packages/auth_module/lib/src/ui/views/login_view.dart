import 'package:core_module/core_module.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../auth_module.dart';
import '../components/template_loading_button_widget.dart';

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
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 28, left: 16),
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
                        errorHintColor: AppColors.codeBorderError,
                        hintText: 'Email',
                      ),
                      validator: (data) {
                        return _store.formValidation(
                          _store.emailValidation(data),
                          _store.isEmailValid,
                        );
                      },
                      errorColor: AppColors.codeBorderError,
                      defaultHintColor: _store.isEmailValid.value
                          ? AppColors.hintInputForm
                          : AppColors.codeBorderError,
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
                      errorColor: AppColors.codeBorderError,
                      inputDecoration: fieldInputDecoration(
                        isValid: _store.isPasswordValid.value,
                        hintText: 'Senha',
                        errorHintColor: AppColors.codeBorderError,
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
                      isPressed: _store.isLoginPressed,
                      action: () async {
                        _store.loginValidate(context: context);
                      },
                      isValid:
                      ValueNotifier(_store.isEmailValid.value &&
                          _store.isPasswordValid.value),
                      label: "Entrar",
                    ),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.loginLineDecoration,
                          ),
                        ),
                        width: 159,
                      ),
                    ),
                    TemplateLoadingButtonWidget(
                      isPressed: _store.isGoogleLoginPressed,
                      action: () {
                        _store.googleSignIn(context);
                      },
                    ),
                    /* ProviderButtonWidget(
                      isPressed: _store.isGoogleLoginPressed,
                      action: () {
                        _store.googleSignIn(context);
                      },
                      size: 32,
                      icon:  AppIcons.faceIcon,
                      label: "Continuar com o Facebook",
                    ),*/
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
                                  pushNamed(
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
          ),
        );
      },
    );
  }
}
