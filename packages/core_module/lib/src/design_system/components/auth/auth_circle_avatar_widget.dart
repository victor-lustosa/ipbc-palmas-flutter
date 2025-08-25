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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _store.validateAuthentication();
    });
  }

  void updateAuthAvatar() {
    setState(() {
      _store.validateAuthentication();
    });
  }
  @override
  Widget build(BuildContext context) {
    final store = Modular.get<AuthCircleAvatarStore>();
    if (store.value is InitialState) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        store.validateAuthentication();
      });
    }

    return ValueListenableBuilder<GenericState<AuthCircleAvatarState>>(
      valueListenable: store,
      builder: (_, state, __) {
        if (state is LoadingState || state is InitialState) {
          return SizedBox(
            width: 32,
            height: 32,
            child: CircularProgressIndicator(strokeWidth: 2),
          );
        }

        if (state is AuthenticatedState) {
          return Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.darkGreen, width: 2),
            ),
            child: ButtonWidget(
              shape: const CircleBorder(),
              action: () => pushNamed(AppRoutes.authRoute + AppRoutes.loginRoute),
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: _store.userEntity.picture,
                  width: 32,
                  height: 32,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Image.asset(AppIcons.noProfile),
                  errorWidget: (context, url, error) => Image.asset(AppIcons.noProfile),
                ),
              ),
            ),
          );
        }
        return ButtonWidget(
          action: () => pushNamed(AppRoutes.authRoute + AppRoutes.loginRoute),
          child: SizedBox(
            width: 32,
            height: 32,
            child: Image.asset(AppIcons.noProfile),
          ),
        );
      },
    );
  }
}