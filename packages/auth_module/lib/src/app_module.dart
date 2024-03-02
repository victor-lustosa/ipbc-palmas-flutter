import 'package:auth_module/src/ui/controller/code_controller.dart';
import 'package:auth_module/src/ui/views/success_created_new_password_view.dart';
import 'package:auth_module/src/ui/views/verification_code_view.dart';
import 'package:core_module/core_module.dart';

import 'ui/views/create_account_view.dart';
import 'ui/views/creating_new_password_view.dart';
import 'ui/views/login_view.dart';
import 'ui/views/reset_password_view.dart';

class AuthModule extends Module {
  @override
  List<Module> get imports => [CoreModule()];
  @override
  void binds(i) {
    i.add(
      () => LoginViewModel(
        useCase: AuthUseCase(
          repository: Repository<HiveAuthDTO>(
            datasource: HiveDatasource<HiveAuthDTO>(boxLabel: 'auth'),
          ),
        ),
      ),
    );
    i.addSingleton(CodeController.new);
  }

  static const String initialRoute = '/auth';
  static const String loginRoute = '/login';
  static const String createAccountRoute = '/create-account';
  static const String verificationCodeRoute = '/verification-code';
  static const String creatingNewPassWordRoute = '/creating-new-password';
  static const String successPasswordChangeRoute = '/success-password';
  static const String resetPasswordRoute = '/reset-password';

  @override
  void routes(r) {
    r.child(initialRoute, child: (context) => const LoginView());
    r.child(loginRoute, child: (context) => const LoginView());
    r.child(createAccountRoute, child: (context) => const CreateAccountView());
    r.child(resetPasswordRoute, child: (context) => const ResetPassword());

    r.child(verificationCodeRoute,
        child: (context) => const VerificationCodePage());
    r.child(creatingNewPassWordRoute,
        child: (context) => const CreatingNewPasswordView());
    r.child(successPasswordChangeRoute,
        child: (context) => const CreatedNewPasswordsuccess());
  }
}
