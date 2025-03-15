import 'package:auth_module/src/ui/stores/create_account_store.dart';
import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../auth_module.dart';

class CreateAccountView extends StatefulWidget {
  const CreateAccountView({super.key});

  @override
  State<CreateAccountView> createState() => _CreateAccountViewState();
}

class _CreateAccountViewState extends State<CreateAccountView> {
  final _store = Modular.get<CreateAccountStore>();

  final _emailKey = GlobalKey<FormState>();
  final _passwordKey = GlobalKey<FormState>();
  final _repeatPasswordKey = GlobalKey<FormState>();

  final String _emailErrorText = 'por favor, insira um email válido.';
  final String _passwordErrorText = 'por favor, insira uma senha.';
  final String _passwordErrorConfirmText = 'por favor, Repita a senha.';

  bool _isEmailValid = true;
  bool _isPasswordValid = true;
  bool _obscure = true;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    suffixAction() => setState(() {
      _obscure = !_obscure;
    });

    return ValueListenableBuilder(
      valueListenable: _store,
      builder: (_, state, child) {
        if (state is LoadingState<CreateAccountState>) {
          _isPressed = true;
        }
        if (state is InitialState<CreateAccountState>) {
          _isPressed = false;
        }

        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 72, left: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        BackButtonWidget(
                          action:
                              () => Modular.to.navigate(
                                AppRoutes.authRoute + AppRoutes.loginRoute,
                              ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 32),
                    child: const Image(
                      image: AssetImage(AppImages.logoLoginImage),
                      fit: BoxFit.cover,
                      width: 166,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 24),
                    child: Text(
                      'Criar Conta',
                      style: AppFonts.defaultFont(
                        color: AppColors.grey10,
                        fontSize: 22,
                      ),
                    ),
                  ),
                  TemplateFormWidget(
                    controller: _store.emailController,
                    title: 'Insira seu email',
                    isValid: _isEmailValid,
                    errorText: _emailErrorText,
                    globalKey: _emailKey,
                    isPressed: _isPressed,
                    color:
                        _store.emptyEmail
                            ? AppColors.secondaryGrey
                            : (_isEmailValid
                                ? AppColors.greenInputAccept
                                : AppColors.delete),
                    inputDecoration: fieldInputDecoration(
                      isValid: _isEmailValid,
                      hintText: 'Email',
                    ),
                    validator: (data) {
                      return _emailValidation(data);
                    },
                    defaultHintColor:
                        _isEmailValid
                            ? AppColors.greenInputAccept
                            : AppColors.delete,
                  ),
                  TemplateFormWidget(
                    controller: _store.passwordController,
                    titleMargin: EdgeInsets.only(
                      top: _isPasswordValid ? 24 : 12,
                    ),
                    title: 'Crie a sua senha',
                    isValid: _isPasswordValid,
                    errorText: _passwordErrorText,
                    globalKey: _passwordKey,
                    isPressed: _isPressed,
                    obscure: _obscure,
                    color:
                        _store.emptyPasswords
                            ? AppColors.secondaryGrey
                            : (!_store.emptyPasswords && _store.isPasswordEqual
                                ? AppColors.disableButton
                                : AppColors.delete),
                    inputDecoration: fieldInputDecoration(
                      isValid: _isPasswordValid,
                      hintText: 'Senha',
                      contentPadding: const EdgeInsets.only(left: 16, top: 9),
                      suffixIcon:
                          _obscure
                              ? IconButtonWidget(
                                action: suffixAction,
                                size: 24,
                                color: AppColors.grey7,
                                iOSIcon: CupertinoIcons.eye_slash,
                                androidIcon: Icons.visibility_off_outlined,
                              )
                              : IconButtonWidget(
                                action: suffixAction,
                                size: 24,
                                color: AppColors.grey7,
                                iOSIcon: CupertinoIcons.eye,
                                androidIcon: Icons.visibility_outlined,
                              ),
                    ),
                    validator: (data) {
                      return _passwordValidation(data);
                    },
                    defaultHintColor:
                        _isPasswordValid && _store.isPasswordEqual
                            ? AppColors.greenInputAccept
                            : AppColors.delete,
                  ),
                  TemplateFormWidget(
                    controller: _store.passwordRepeatController,
                    titleMargin: const EdgeInsets.only(top: 8),
                    isValid: _isPasswordValid,
                    errorText: _passwordErrorConfirmText,
                    globalKey: _repeatPasswordKey,
                    isPressed: _isPressed,
                    obscure: _obscure,
                    color:
                        _store.emptyPasswords
                            ? AppColors.secondaryGrey
                            : (!_store.emptyPasswords && _store.isPasswordEqual
                                ? AppColors.disableButton
                                : AppColors.delete),
                    inputDecoration: fieldInputDecoration(
                      isValid: _isPasswordValid,
                      hintText: 'Repita a Senha',
                      contentPadding: const EdgeInsets.only(left: 16, top: 9),
                      suffixIcon:
                          _obscure
                              ? IconButtonWidget(
                                action: suffixAction,
                                size: 24,
                                color: AppColors.grey7,
                                iOSIcon: CupertinoIcons.eye_slash,
                                androidIcon: Icons.visibility_off_outlined,
                              )
                              : IconButtonWidget(
                                action: suffixAction,
                                size: 24,
                                color: AppColors.grey7,
                                iOSIcon: CupertinoIcons.eye,
                                androidIcon: Icons.visibility_outlined,
                              ),
                    ),
                    validator: (data) {
                      return _passwordValidation(data);
                    },
                    defaultHintColor:
                        _isPasswordValid && _store.isPasswordEqual
                            ? AppColors.greenInputAccept
                            : AppColors.delete,
                  ),
                  Container(
                    width: context.sizeOf.width,
                    margin: const EdgeInsets.only(left: 16, top: 8, right: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _store.isPasswordLengthValid
                              ? " * A senha contém 8 dígitos."
                              : " * Deve conter no mínimo 8 dígitos.",
                          style: AppFonts.defaultFont(
                            color:
                                _store.emptyPasswords
                                    ? AppColors.grey10
                                    : _store.isPasswordLengthValid
                                    ? AppColors.disableButton
                                    : AppColors.delete,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          _store.isPasswordEqual
                              ? " * As senhas correspondem."
                              : " * As senhas devem corresponder.",
                          style: AppFonts.defaultFont(
                            color:
                                _store.emptyPasswords
                                    ? AppColors.grey10
                                    : _store.isPasswordEqual
                                    ? AppColors.disableButton
                                    : AppColors.delete,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  LoadingButtonWidget(
                    marginTop: 16,
                    marginBottom: 24,
                    loadingWidth: 55,
                    isPressed: _isPressed,
                    action: () {
                      _store.emptyData &&
                              _store.isPasswordEqual &&
                              _isEmailValid
                          ? _store.validateCode(context)
                          : null;
                    },
                    isValid:
                        _isEmailValid &&
                        _isPasswordValid &&
                        _store.isPasswordEqual,
                    label: "Criar Conta",
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
                  Container(
                    margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
                    height: 48,
                    width: context.sizeOf.width,
                    child: ButtonWidget(
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
                          const Text("Fazer login com o Google"),
                          const SizedBox(width: 18),
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
                          const Text("Fazer login com o Facebook"),
                        ],
                      ),
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

  _passwordBorderValidation(bool value) {
    Future.delayed(Duration.zero, () async {
      if (mounted) {
        setState(() {
          _isPasswordValid = value;
        });
      }
    });
  }

  _emailBorderValidation(bool value) {
    Future.delayed(Duration.zero, () async {
      if (mounted) {
        setState(() {
          _isEmailValid = value;
        });
      }
    });
  }

  _emailValidation(String? data) {
    if (data == null || data.isEmpty) {
      _emailBorderValidation(false);
    } else {
      if (EmailValidator.validate(_store.emailController.text)) {
        _emailBorderValidation(true);
      } else {
        _emailBorderValidation(false);
      }
    }
  }

  _passwordValidation(String? data) {
    if (data == null || data.isEmpty) {
      _passwordBorderValidation(false);
    } else {
      _passwordBorderValidation(true);
    }
  }
}
