import 'package:core_module/core_module.dart';
import 'package:auth_module/src/ui/stores/auth_circle_avatar_store.dart';
import 'package:flutter/material.dart';

class AuthCircleAvatarWidget extends StatefulWidget {
  const AuthCircleAvatarWidget({
    super.key,
    this.picture,
    this.isLogged = false,
    this.loginAction,
    this.logoutAction,
  });

  final String? picture;
  final bool isLogged;
  final VoidCallback? loginAction;
  final VoidCallback? logoutAction;

  @override
  State<AuthCircleAvatarWidget> createState() => _AuthCircleAvatarWidgetState();
}

class _AuthCircleAvatarWidgetState extends State<AuthCircleAvatarWidget> {
  final AuthCircleAvatarState _store = Modular.get<AuthCircleAvatarState>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 32,
      height: 32,
      child: ButtonWidget(
        backgroundColor: widget.isLogged ? AppColors.darkGreen : null,
        shape: widget.isLogged ? const CircleBorder() : null,
        padding: widget.isLogged ? const EdgeInsets.all(2) : null,
        action:
            widget.isLogged
                ? (widget.logoutAction ?? () {})
                : (widget.loginAction ??
                    () => pushNamed(
                      AuthModule.authRoute + AuthModule.loginRoute,
                    )),
        child:
            widget.picture == ''
                ? Image.asset(AppIcons.noProfile)
                : CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.grey,
                  backgroundImage: NetworkImage(widget.picture ?? ''),
                ),
      ),
    );
  }
}
