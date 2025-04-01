import 'package:flutter/cupertino.dart';
import 'package:core_module/core_module.dart';

class AuthCircleAvatarStore extends ValueNotifier<GenericState<AuthCircleAvatarState>> {
  AuthCircleAvatarStore({required IOfflineAuthUseCases offlineUse})
    : _offlineUseCases = offlineUse,
      super(LoadingState<AuthCircleAvatarState>());

  UserEntity userEntity = UserModel.empty();

  late final IOfflineAuthUseCases _offlineUseCases;

  Future<void> validateAuthentication(BuildContext context) async {
    value = LoadingState<AuthCircleAvatarState>();

      final result = await _offlineUseCases.getLocalUser();
      if (result != null) {
        userEntity = result;
        value = AuthenticatedState();
        if(context.mounted){
          precacheImage(NetworkImage(userEntity.picture), context);
        }
      } else {
        value = NotAuthenticatedState();
      }
   
  }
}

@immutable
abstract class AuthCircleAvatarState {}

class AuthenticatedState extends GenericState<AuthCircleAvatarState> {}

class NotAuthenticatedState extends GenericState<AuthCircleAvatarState> {}
