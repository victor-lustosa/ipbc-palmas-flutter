import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';

class AuthCircleAvatarStore
    extends ValueNotifier<GenericState<AuthCircleAvatarState>> {
  AuthCircleAvatarStore({required IAuthUseCases authUseCase})
    : _authUseCase = authUseCase,
      super(InitialState<AuthCircleAvatarState>());

  UserEntity userEntity = UserEntity.empty();

  late final IAuthUseCases _authUseCase;

  Future<void> validateAuthentication() async {
    value = LoadingState<AuthCircleAvatarState>();

    final result = await _authUseCase.getLocalUser();
    if (result != null) {
      userEntity = result;
      Future.delayed(const Duration(milliseconds: 500), () {
        value = AuthenticatedState();
      });
    } else {
      Future.delayed(const Duration(milliseconds: 500), () {
        value = NotAuthenticatedState();
      });
    }
  }

  void logout() async {
    value = LoadingState<AuthCircleAvatarState>();
    await _authUseCase.logoutWithGoogle(
      id: int.parse(userEntity.id),
      provider: userEntity.provider,
    );
    userEntity = UserEntity.empty();
    Future.delayed(const Duration(milliseconds: 500), () {
      value = NotAuthenticatedState();
    });
  }
}

@immutable
abstract class AuthCircleAvatarState {}

class AuthenticatedState extends GenericState<AuthCircleAvatarState> {}

class NotAuthenticatedState extends GenericState<AuthCircleAvatarState> {}
