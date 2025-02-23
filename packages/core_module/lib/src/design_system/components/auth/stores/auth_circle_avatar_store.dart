import 'package:flutter/cupertino.dart';
import 'package:core_module/core_module.dart';

class AuthCircleAvatarStore
    extends ValueNotifier<GenericState<AuthCircleAvatarState>> {
  AuthCircleAvatarStore({required IOfflineAuthUseCases offlineUse})
    : _offlineUseCases = offlineUse,
      super(LoadingState<AuthCircleAvatarState>());

  UserEntity userEntity = UserModel.empty();

  bool isLogged = false;

  late final IOfflineAuthUseCases _offlineUseCases;

  Future<void> validateAuthentication() async {
    value = LoadingState<AuthCircleAvatarState>();
    Future.delayed(const Duration(milliseconds: 500), () async {
      final result = await _offlineUseCases.getToken();
      if (result != null) {
        await getLocalUser();
        value = AuthenticatedState();
      } else {
        value = NotAuthenticatedState();
      }
    });
  }

  Future<void> getLocalUser() async {
    final result = await _offlineUseCases.getLocalUser();
    if (result != null) {
      userEntity = result;
    }
  }
}

@immutable
abstract class AuthCircleAvatarState {}

class AuthenticatedState extends GenericState<AuthCircleAvatarState> {}

class ReloadingState extends GenericState<AuthCircleAvatarState> {}

class NotAuthenticatedState extends GenericState<AuthCircleAvatarState> {}
