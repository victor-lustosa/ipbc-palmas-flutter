import 'package:flutter/cupertino.dart';
import 'package:core_module/core_module.dart';

class AuthCircleAvatarStore extends ValueNotifier<GenericState<AuthCircleAvatarState>> {
  AuthCircleAvatarStore({required IOfflineAuthUseCases offlineUse, required IOnlineAuthUseCases onlineUse})
      : _onlineUseCases = onlineUse,
        _offlineUseCases = offlineUse,
      super(InitialState<AuthCircleAvatarState>());

  UserEntity userEntity = UserModel.empty();

  late final IOfflineAuthUseCases _offlineUseCases;
  late final IOnlineAuthUseCases _onlineUseCases;

  Future<void> validateAuthentication() async {
    value = LoadingState<AuthCircleAvatarState>();

    final result = await _offlineUseCases.getLocalUser();
    if (result != null) {
      userEntity = result;
      Future.delayed(const Duration(milliseconds: 500),(){
        value = AuthenticatedState();
      });
    } else {
      Future.delayed(const Duration(milliseconds: 500),(){
      value = NotAuthenticatedState();
      });
    }
  }

  void logoutWithGoogle() async{
    await _onlineUseCases.logoutWithGoogle();
    final result = await _offlineUseCases.logoutWithGoogle(params: {'id': userEntity.id});
    print(result);
    userEntity = UserModel.empty();
    Future.delayed(const Duration(milliseconds: 500),(){
      value = NotAuthenticatedState();
    });
  }
}

@immutable
abstract class AuthCircleAvatarState {}

class AuthenticatedState extends GenericState<AuthCircleAvatarState> {}

class NotAuthenticatedState extends GenericState<AuthCircleAvatarState> {}
