import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class AuthCircleAvatarWidget extends StatefulWidget {
  const AuthCircleAvatarWidget({super.key});

  @override
  State<AuthCircleAvatarWidget> createState() => AuthCircleAvatarWidgetState();
}

class AuthCircleAvatarWidgetState extends State<AuthCircleAvatarWidget> {
  final AuthCircleAvatarStore _store = Modular.get<AuthCircleAvatarStore>();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<GenericState<AuthCircleAvatarState>>(
      valueListenable: _store,
      builder: (_, state, __) {
        noProfile(bool isCircularActivated) => SizedBox(
          width: 32,
          height: 32,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(AppIcons.noProfile),
              Visibility(
                visible: isCircularActivated,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColors.darkGreen,
                  ),
                  strokeWidth: 1,
                ),
              ),
            ],
          ),
        );
        if (state is LoadingState<AuthCircleAvatarState>) {
          return noProfile(true);
        }
          return Container(
            width: 32,
            height: 32,
            decoration: state is AuthenticatedState
            ? BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.darkGreen, width: 2),
            ) : null,
            child: ButtonWidget(
              backgroundColor: Colors.transparent,
              overlayColor: Colors.transparent,
              elevation: 0,
              shape: const CircleBorder(),
              action:
                  () => state is AuthenticatedState
                  ? pushNamed(AppRoutes.authRoute + AppRoutes.loginRoute)
                  : pushNamed(AppRoutes.authRoute + AppRoutes.loginRoute),
              child: _store.userEntity.picture.isEmpty ? noProfile(false) : ClipOval(
                child: CachedNetworkImage(
                  imageUrl: _store.userEntity.picture,
                  width: 32,
                  height: 32,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => noProfile(true),
                  errorWidget: (context, url, error) =>
                      Image.asset(AppIcons.noProfile),
                ),
              ),
            ),
          );
        }
    );
  }
}
