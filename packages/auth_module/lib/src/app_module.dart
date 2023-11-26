import 'package:auth_module/src/ui/views/success_created_new_password_view.dart';
import 'package:core_module/core_module.dart';

import 'infra/use_cases/auth_use_case.dart';
import 'ui/views/create_account_view.dart';
import 'ui/views/login_view.dart';
import 'ui/view_models/login_view_model.dart';

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

  @override
  void routes(r) {
    r.child('/', child: (context) => const LoginView());
    r.child('/login', child: (context) => const LoginView());
    r.child('/create-account', child: (context) => const CreateAccountView());
    r.child('/sucess-created-new-password',
        child: (context) => const CreatedNewPasswordsuccess());
  }
}
