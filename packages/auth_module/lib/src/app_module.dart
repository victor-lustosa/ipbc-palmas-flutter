import 'package:auth_module/src/ui/view_models/password_view_model.dart';
import 'package:auth_module/src/ui/views/new_password_view.dart';
import 'package:auth_module/src/ui/views/verification_code_view.dart';
import 'package:core_module/core_module.dart';

import 'ui/views/create_account_view.dart';
import 'ui/views/creating_new_password_view.dart';
import 'ui/views/login_view.dart';
import 'ui/views/reset_password_view.dart';

class AuthModule extends Module {

  static const String initialRoute = '/auth';
  static const String authRoute = '/auth';
  static const String loginRoute = '/login';
  static const String createAccountRoute = '/create-account';
  static const String verificationCodeRoute = '/verification-code';
  static const String creatingNewPassWordRoute = '/creating-new-password';
  static const String successPasswordChangeRoute = '/success-password';
  static const String resetPasswordRoute = '/reset-password';

  @override
  List<Module> get imports => [CoreModule()];
  @override
  void binds(i) {
    i.add(()=> AuthUseCase(
      repository: Repository<dynamic>(
        datasource: HiveDatasource<HiveAuthDTO>(boxLabel: 'auth'),
      ),
    ),);
    i.add(
      () => LoginViewModel(
        useCase: i.get<AuthUseCase>(),
      ),
    );
    i.addSingleton(PasswordViewModel.new);
  }


  @override
  void routes(r) {
    r.child(initialRoute, child: (context) => const LoginView());
    r.child(loginRoute, child: (context) => const LoginView());
    r.child(createAccountRoute, child: (context) => const CreateAccountView());
    r.child(resetPasswordRoute, child: (context) => const ResetPasswordView());

    r.child(verificationCodeRoute,
        child: (context) => const VerificationCodeView());
    r.child(creatingNewPassWordRoute,
        child: (context) => const CreatingNewPasswordView());
    r.child(successPasswordChangeRoute,
        child: (context) => const NewPasswordView());
  }
}
