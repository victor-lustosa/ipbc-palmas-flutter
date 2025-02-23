import 'package:auth_module/src/ui/views/registration_completion_view.dart';
import 'package:core_module/core_module.dart';
import 'package:flutter/animation.dart';

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
        offlineUse: i.get<IOfflineAuthUseCases>(),
        onlineUse: i.get<IOnlineAuthUseCases>(),
      ),
    );
    i.addSingleton<IOnlineAuthUseCases>(
          () => OnlineAuthUseCases(
        repository: SupaAuthRepository(supaClient: i.get<SupabaseClient>()),
      ),
    );
    i.addSingleton(ResetPasswordStore.new);
    i.addLazySingleton(CreateAccountStore.new);
    i.addSingleton(RegistrationCompletionStore.new);
  }

  @override
  void routes(r) {
    r.child(
      AppRoutes.loginRoute,
      transition: TransitionType.custom,
      customTransition: ModularSlideTransition(
        transitionDuration: const Duration(milliseconds: 400),
        reverseTransitionDuration: const Duration(milliseconds: 400),
        begin: const Offset(1, 0),
        end: const Offset(0, 0),
        curve: Curves.easeIn,
      ),
      child: (_) => const LoginView(),
    );
    r.child(AppRoutes.createAccountRoute, child: (_) => const CreateAccountView());
    r.child(AppRoutes.resetPasswordRoute, child: (_) => const ResetPasswordView());
    r.child(AppRoutes.verificationCodeRoute, child: (_) => const VerificationCodeView());
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
  }
}
