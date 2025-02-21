import 'package:flutter/material.dart';

import '../../../../core_module.dart';
import '../auth/logo_icon_widget.dart';

class MainTopBarWidget extends StatelessWidget {
  const MainTopBarWidget({
    super.key,
    this.margin,
    this.topBarList,
    this.mainAxisAlignment,
    this.picture,
    this.isLogged,
    this.loginAction,
    this.logoutAction,
  });

  final String? picture;
  final bool? isLogged;
  final VoidCallback? loginAction;
  final VoidCallback? logoutAction;
  final EdgeInsetsGeometry? margin;
  final List<Widget>? topBarList;
  final MainAxisAlignment? mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Container(
          margin:
              margin ??
              const EdgeInsets.only(top: 28, left: 16, right: 18, bottom: 24),
          child: Row(
            mainAxisAlignment:
                mainAxisAlignment ?? MainAxisAlignment.spaceBetween,
            children:
                topBarList ??
                [
                  LogoIconWidget(),
                  AuthCircleAvatarWidget(
                    picture: picture,
                    isLogged: isLogged ?? false,
                    loginAction: loginAction,
                    logoutAction: logoutAction,
                  ),
                ],
          ),
        );
      },
    );
  }
}
