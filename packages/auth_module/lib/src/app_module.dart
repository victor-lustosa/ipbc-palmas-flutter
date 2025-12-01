import 'package:auth_module/src/ui/views/account_created_successfully_view.dart';
import 'package:auth_module/src/ui/views/could_not_create_account_view.dart';
import 'package:auth_module/src/ui/views/registration_completion_view.dart';
import 'package:core_module/core_module.dart';

import '../auth_module.dart';
import 'ui/stores/create_account_store.dart';
import 'ui/stores/registration_completion_store.dart';
import 'ui/stores/reset_password_store.dart';
import 'ui/views/create_account_view.dart';
import 'ui/views/creating_new_password_view.dart';
import 'ui/views/login_view.dart';
import 'ui/views/reset_password_success_view.dart';
import 'ui/views/reset_password_view.dart';
import 'ui/views/verification_code_view.dart';

class AuthModule extends Module {
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(i) {
    i.addLazySingleton(
      () => LoginStore(
        useCases: i.get<IAuthUseCases>(),
        authCircleAvatarStore: i.get<AuthCircleAvatarStore>(),
      ),
    );
    i.addSingleton(ResetPasswordStore.new);
    i.addLazySingleton(CreateAccountStore.new);
    i.addSingleton(RegistrationCompletionStore.new);
  }

  @override
  void routes(r) {
    r.child(AppRoutes.loginRoute, child: (_) => const LoginView());
    r.child(
      AppRoutes.createAccountRoute,
      transition: TransitionType.custom,
      customTransition: UniversalModularTransition(
        enterType: .fade,
        duration: Duration(milliseconds: 150),
        reverseDuration: Duration(milliseconds: 150),
      ),
      child: (_) => const CreateAccountView(),
    );
    r.child(
      AppRoutes.resetPasswordRoute,
      child: (_) => const ResetPasswordView(),
    );
    r.child(
      AppRoutes.verificationCodeRoute,
      child: (_) => const VerificationCodeView(),
    );
    r.child(
      AppRoutes.creatingNewPassWordRoute,
      child: (_) => const CreatingNewPasswordView(),
    );
    r.child(
      AppRoutes.resetPasswordSuccessRoute,
      child: (_) => const ResetPasswordSuccessView(),
    );
    r.child(
      AppRoutes.registrationCompletionRoute,
      child: (_) => const RegistrationCompletionView(),
    );
    r.child(
      AppRoutes.couldNotCreateRoute,
      child: (_) => const CouldNotCreateAccountView(),
    );
    r.child(
      AppRoutes.accountCreatedRoute,
      transition: TransitionType.custom,
      customTransition: UniversalModularTransition(
        enterType: .fade,
        duration: Duration(milliseconds: 150),
        reverseDuration: Duration(milliseconds: 150),
      ),
      child: (_) => const AccountCreatedSuccessfullyView(),
    );
  }
}
