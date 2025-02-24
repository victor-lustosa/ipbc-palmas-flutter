import 'package:flutter/cupertino.dart';
import 'package:core_module/core_module.dart';

class AuthCircleAvatarStore extends ValueNotifier<GenericState<AuthCircleAvatarState>> {
  AuthCircleAvatarStore({required IOfflineAuthUseCases offlineUse})
    : _offlineUseCases = offlineUse,
      super(LoadingState<AuthCircleAvatarState>());

  UserEntity userEntity = UserModel.empty();

  late final IOfflineAuthUseCases _offlineUseCases;

  Future<void> validateAuthentication() async {
    value = LoadingState<AuthCircleAvatarState>();
    Future.delayed(const Duration(milliseconds: 700), () async {
      final result = await _offlineUseCases.getLocalUser();
      if (result != null) {
        userEntity = result;
        value = AuthenticatedState();
      } else {
        value = NotAuthenticatedState();
      }
    });
  }
}

@immutable
abstract class AuthCircleAvatarState {}

class AuthenticatedState extends GenericState<AuthCircleAvatarState> {}

class NotAuthenticatedState extends GenericState<AuthCircleAvatarState> {}
