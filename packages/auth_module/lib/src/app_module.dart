import 'package:auth_module/src/ui/views/success_created_new_password_view.dart';
import 'package:core_module/core_module.dart';

import 'ui/views/create_account_view.dart';
import 'ui/views/login_view.dart';

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
  }
  static const String initialRoute = '/';
  static const String loginRoute = '/login';
  static const String createAccountRoute = '/create-account';
  static const String successPasswordChangeRoute = '/success-password';
  @override
  void routes(r) {
    r.child(initialRoute, child: (context) => const LoginView());
    r.child(loginRoute, child: (context) => const LoginView());
    r.child(createAccountRoute, child: (context) => const CreateAccountView());
    r.child(successPasswordChangeRoute,
        child: (context) => const CreatedNewPasswordsuccess());
  }
}
