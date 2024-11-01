import 'package:auth_module/src/infra/repositories/supa_auth_repository.dart';
import 'package:auth_module/src/ui/views/registration_completion_view.dart';
import 'package:home_module/home_module.dart';

import 'ui/stores/create_account_store.dart';
import 'ui/stores/login_store.dart';
import 'ui/stores/registration_completion_store.dart';
import 'ui/stores/reset_password_store.dart';
import 'ui/views/create_account_view.dart';
import 'ui/views/creating_new_password_view.dart';
import 'ui/views/login_view.dart';
import 'ui/views/reset_password_success_view.dart';
import 'ui/views/reset_password_view.dart';
import 'ui/views/verification_code_view.dart';

class AuthModule extends Module {
  static const String authRoute = '/auth';
  static const String loginRoute = '/login';
  static const String createAccountRoute = '/create-account';
  static const String verificationCodeRoute = '/verification-code';
  static const String creatingNewPassWordRoute = '/creating-new-password';
  static const String resetPasswordSuccessRoute = '/success-password';
  static const String resetPasswordRoute = '/reset-password';
  static const String registrationCompletionRoute = '/registration-Completion';

  @override
  List<Module> get imports => [
        CoreModule(),
      ];

  @override
  void binds(i) {
    i.addSingleton<IOfflineAuthUseCases>(
      () => OfflineAuthUseCases(
        repository: HiveRepository<HiveAuthDTO>(
          boxLabel: 'auth',
        ),
      ),
    );
    i.addSingleton<IOnlineAuthUseCases>(
      () => OnlineAuthUseCases(
        service: SupaAuthRepository(supaClient: i.get<SupabaseClient>()),
      ),
    );
    i.addLazySingleton(
      () => LoginStore(
        offlineUse: i.get<IOfflineAuthUseCases>(),
        onlineUse: i.get<IOnlineAuthUseCases>(),
      ),
    );
    i.addSingleton(ResetPasswordStore.new);
    i.addLazySingleton(CreateAccountStore.new);
    i.addSingleton(RegistrationCompletionStore.new);
  }

  @override
  void routes(r) {
    r.child(loginRoute, child: (_) => const LoginView());
    r.child(createAccountRoute, child: (_) => const CreateAccountView());
    r.child(resetPasswordRoute, child: (_) => const ResetPasswordView());
    r.child(verificationCodeRoute, child: (_) => const VerificationCodeView());
    r.child(
      creatingNewPassWordRoute,
      child: (_) => const CreatingNewPasswordView(),
    );
    r.child(
      resetPasswordSuccessRoute,
      child: (_) => const ResetPasswordSuccessView(),
    );
    r.child(
      registrationCompletionRoute,
      child: (_) => const RegistrationCompletionView(),
    );
  }
}
