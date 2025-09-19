import 'package:auth_module/src/ui/stores/create_account_store.dart';
import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class CreateAccountView extends StatefulWidget {
  const CreateAccountView({super.key});

  @override
  State<CreateAccountView> createState() => _CreateAccountViewState();
}

class _CreateAccountViewState extends State<CreateAccountView> {
  late final CreateAccountStore _store;

  @override
  void initState() {
    super.initState();
    _store = Modular.get<CreateAccountStore>();
  }

  @override
  void dispose() {
    _store.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _store,
      builder: (_, state, child) {

      bool isInitPassword = _store.passwordInitState.value && _store.secondPasswordInitState.value;

       Widget point = Container(
          margin: const EdgeInsets.only(right: 5),
          height: 5,
          width: 5,
          decoration: BoxDecoration(
            color:  isInitPassword
                ? AppColors.grey7
                : _store.isPasswordLengthValid
                ? AppColors.greenInputAccept
                : AppColors.codeBorderError,
            shape: BoxShape.circle,
          ),
        );

        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 28, left: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
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
                    isValid: _store.isEmailValid.value,
                    errorText: _store.emailErrorText,
                    globalKey: _store.emailKey,
                    isPressed: _store.isCreateAccountPressed,
                    errorColor: AppColors.codeBorderError,
                    color: _store.emailInitState.value
                        ? AppColors.secondaryGrey
                        : _store.isEmailValid.value
                        ? AppColors.greenInputAccept
                        : AppColors.codeBorderError,
                    inputDecoration: fieldInputDecoration(
                      isValid: _store.isEmailValid.value,
                      errorHintColor: AppColors.codeBorderError,
                      hintText: 'Email',
                    ),
                    onChanged: (value){
                      _store.emailInitState.value = false;
                    },
                    validator: (data) {
                      return _store.formValidation(
                        _store.emailValidation(data),
                        _store.isEmailValid,
                      );
                    },
                    defaultHintColor: _store.isEmailValid.value
                        ? AppColors.greenInputAccept
                        : AppColors.codeBorderError,
                  ),
                  TemplateFormWidget(
                    controller: _store.passwordController,
                    titleMargin: EdgeInsets.only(
                      top: 24,
                    ),
                    title: 'Crie a sua senha',
                    globalKey: _store.passwordKey,
                    isPressed: _store.isCreateAccountPressed,
                    obscure: _store.firstObscure,
                    errorColor: AppColors.codeBorderError,
                    color: _store.passwordInitState.value
                        ? AppColors.secondaryGrey
                        : !_store.emptyPasswords && _store.isPasswordEqual
                        ? AppColors.greenInputAccept
                        : AppColors.codeBorderError,
                    inputDecoration: fieldInputDecoration(
                      errorHintColor: AppColors.codeBorderError,
                      isValid: _store.isPasswordValid.value,
                      hintText: 'Senha',
                      contentPadding: const EdgeInsets.only(left: 16, top: 9),
                      suffixIcon: HideIconWidget(
                        isObscure: _store.firstObscure,
                      ),
                    ),
                    validator: (data) {
                      return _store.formValidation(
                        !_store.isEmptyData(data),
                        _store.isPasswordValid,
                      );
                    },
                    onChanged: (value){
                      _store.passwordInitState.value = false;
                    },
                    defaultHintColor:
                        _store.isPasswordValid.value && _store.isPasswordEqual
                        ? AppColors.greenInputAccept
                        : AppColors.codeBorderError,
                  ),
                  TemplateFormWidget(
                    controller: _store.passwordRepeatController,
                    titleMargin: const EdgeInsets.only(top: 8),
                    globalKey: _store.repeatPasswordKey,
                    isPressed: _store.isCreateAccountPressed,
                    obscure: _store.secondObscure,
                    errorColor: AppColors.codeBorderError,
                    color: _store.secondPasswordInitState.value
                        ? AppColors.secondaryGrey
                        : !_store.emptyPasswords && _store.isPasswordEqual
                        ? AppColors.greenInputAccept
                        : AppColors.codeBorderError,
                    inputDecoration: fieldInputDecoration(
                      errorHintColor: AppColors.codeBorderError,
                      isValid: _store.isSecondPasswordValid.value,
                      hintText: 'Repita a Senha',
                      contentPadding: const EdgeInsets.only(left: 16, top: 9),
                      suffixIcon: HideIconWidget(
                        isObscure: _store.secondObscure,
                      ),
                    ),
                    onChanged: (value){
                      _store.secondPasswordInitState.value = false;
                    },
                    validator: (data) {
                      return _store.formValidation(
                        !_store.isEmptyData(data),
                        _store.isSecondPasswordValid,
                      );
                    },
                    defaultHintColor:
                        _store.isSecondPasswordValid.value &&
                            _store.isPasswordEqual
                        ? AppColors.greenInputAccept
                        : AppColors.codeBorderError,
                  ),
                  Container(
                    width: context.sizeOf.width,
                    margin: const EdgeInsets.only(left: 20, top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            point,
                            Text(
                              _store.isPasswordLengthValid
                                  ? "As senhas contém 8 dígitos."
                                  : "Deve conter no mínimo 8 dígitos.",
                              style: AppFonts.defaultFont(
                                color:  isInitPassword
                                    ? AppColors.grey7
                                    :_store.isPasswordLengthValid
                                    ? AppColors.greenInputAccept
                                    : AppColors.codeBorderError,
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 8),
                          child: Row(
                            children: [
                              point,
                              Text(
                                _store.isPasswordEqual
                                    ? "As senhas correspondem."
                                    : "As senhas devem corresponder.",
                                style: AppFonts.defaultFont(
                                  color:  isInitPassword
                                      ? AppColors.grey7
                                      : _store.isPasswordEqual
                                      ? AppColors.greenInputAccept
                                      : AppColors.codeBorderError,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  LoadingButtonWidget(
                    isPressed: _store.isCreateAccountPressed,
                    action: () {
                      _store.emptyData &&
                              _store.isPasswordEqual &&
                              _store.isEmailValid.value
                          ? _store.createAccount(context)
                          : null;
                    },
                    isValid:
                        _store.isEmailValid.value &&
                        _store.isPasswordValid.value &&
                        _store.isSecondPasswordValid.value &&
                        _store.isPasswordEqual,
                    label: "Criar Conta",
                  ),
                  /* Center(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.loginLineDecoration,
                        ),
                      ),
                      width: 159,
                    ),
                  ),
                  ProviderButtonWidget(
                    label: 'Fazer cadastro com o Google',
                    isPressed:  _store.isGoogleLoginPressed,
                    action: () {
                    },
                  ),*/
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
