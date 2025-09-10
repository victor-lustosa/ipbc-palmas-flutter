import 'package:flutter/cupertino.dart';
import 'package:core_module/core_module.dart';

class AuthCircleAvatarStore extends ValueNotifier<GenericState<AuthCircleAvatarState>> {
  AuthCircleAvatarStore({required IOfflineAuthUseCases offlineUse, required IOnlineAuthUseCases onlineUse})
      : _onlineUseCases = onlineUse,
        _offlineUseCases = offlineUse,
      super(InitialState<AuthCircleAvatarState>());

  UserEntity userEntity = UserEntity.empty();

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

  void logout() async{
    value = LoadingState<AuthCircleAvatarState>();
    switch(userEntity.provider){
      case 'google':
        await _onlineUseCases.logoutWithGoogle();
        await _offlineUseCases.logoutWithGoogle(params: {'id': int.parse(userEntity.id)});
        break;
      case 'facebook':
        //await logoutWithGoogle();
        break;
      default:
        //await logoutWithGoogle();
    }
    userEntity = UserEntity.empty();
    Future.delayed(const Duration(milliseconds: 500),(){
      value = NotAuthenticatedState();
    });
  }
}

@immutable
abstract class AuthCircleAvatarState {}

class AuthenticatedState extends GenericState<AuthCircleAvatarState> {}

class NotAuthenticatedState extends GenericState<AuthCircleAvatarState> {}
