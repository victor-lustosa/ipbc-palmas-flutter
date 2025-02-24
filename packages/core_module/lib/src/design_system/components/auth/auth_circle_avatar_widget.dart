import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class AuthCircleAvatarWidget extends StatefulWidget {
  const AuthCircleAvatarWidget({super.key});

  @override
  State<AuthCircleAvatarWidget> createState() => _AuthCircleAvatarWidgetState();
}

class _AuthCircleAvatarWidgetState extends State<AuthCircleAvatarWidget> {
  final AuthCircleAvatarStore _store = Modular.get<AuthCircleAvatarStore>();

  @override
  void initState() {
    super.initState();
    _store.validateAuthentication();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _store,
      builder: (_, state, child) {
        if (state is LoadingState<AuthCircleAvatarState>) {
          return SizedBox(
            width: 32,
            height: 32,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(AppIcons.noProfile),
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColors.darkGreen,
                  ),
                  strokeWidth: 1,
                ),
              ],
            ),
          );
        } else {
          return Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color:
                    state is AuthenticatedState
                        ? AppColors.darkGreen
                        : Colors.transparent,
                width: 2,
              ),
            ),
            child: ButtonWidget(
              shape: state is AuthenticatedState ? const CircleBorder() : null,
              action:
                  state is AuthenticatedState
                      ? () =>
                          pushNamed(AppRoutes.authRoute + AppRoutes.loginRoute)
                      : () =>
                          pushNamed(AppRoutes.authRoute + AppRoutes.loginRoute),
              child:
                  state is AuthenticatedState
                      ? CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.transparent,
                        child: ClipOval(
                          child: Image.network(
                            _store.userEntity.picture,
                            width: 32,
                            height: 32,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              return Image.asset(AppIcons.noProfile);
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(AppIcons.noProfile);
                            },
                          ),
                        ),
                      )
                      : Image.asset(AppIcons.noProfile),
            ),
          );
        }
      },
    );
  }
}
