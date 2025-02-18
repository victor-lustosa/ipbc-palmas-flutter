import 'package:auth_module/auth_module.dart';
import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class AuthCircleAvatarWidget extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return SizedBox(
      width: 32,
      height: 32,
      child: ButtonWidget(
        backgroundColor: isLogged ? AppColors.darkGreen : null,
        shape: isLogged ? const CircleBorder() : null,
        padding: isLogged ? const EdgeInsets.all(2) : null,
        action:
            isLogged
                ? (logoutAction ?? () {})
                : (loginAction ??
                    () => pushNamed(
                      AuthModule.authRoute + AuthModule.loginRoute,
                    )),
        child:
            isLogged || picture == null
                ? Image.asset(AppIcons.noProfile)
                : CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.grey,
                  backgroundImage: NetworkImage(picture ?? ''),
                ),
      ),
    );
  }
}
