import 'package:flutter/cupertino.dart';
import 'package:core_module/core_module.dart';

class AuthCircleAvatarStore extends ValueNotifier<GenericState<AuthCircleAvatarState>> {
  AuthCircleAvatarStore({
    required IOfflineAuthUseCases offlineUse,
    required IOnlineAuthUseCases onlineUse,
  }) : _offlineUseCases = offlineUse,
        _onlineUseCases = onlineUse,
        super(InitialState<AuthCircleAvatarState>());

  final IOfflineAuthUseCases _offlineUseCases;
  final IOnlineAuthUseCases _onlineUseCases;

}

@immutable
abstract class AuthCircleAvatarState {}

