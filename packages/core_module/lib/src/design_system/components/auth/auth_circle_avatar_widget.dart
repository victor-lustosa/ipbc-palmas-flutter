import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class AuthCircleAvatarWidget extends StatefulWidget {
  const AuthCircleAvatarWidget({super.key});

  @override
  State<AuthCircleAvatarWidget> createState() => AuthCircleAvatarWidgetState();
}

class AuthCircleAvatarWidgetState extends State<AuthCircleAvatarWidget>
    with TickerProviderStateMixin {
  final AuthCircleAvatarStore _store = Modular.get<AuthCircleAvatarStore>();
  late final AnimationController _shimmerController;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController.unbounded(vsync: this)
      ..repeat(min: -0.5, max: 1.5, period: const Duration(milliseconds: 1200));
  }

  @override
  dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<GenericState<AuthCircleAvatarState>>(
      valueListenable: _store,
      builder: (_, state, __) {
        placeholder() => ShimmerWidget(
          animation: _shimmerController,
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.shade300,
            ),
          ),
        );

        noProfile() => SizedBox(
          width: 32,
          height: 32,
          child: ButtonWidget(
            backgroundColor: Colors.transparent,
            overlayColor: Colors.transparent,
            elevation: 0,
            shape: const CircleBorder(),
            action: () => state is AuthenticatedState
                ? pushNamed(AppRoutes.authRoute + AppRoutes.loginRoute)
                : pushNamed(AppRoutes.authRoute + AppRoutes.loginRoute),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(AppIcons.noProfile),
                Visibility(
                  visible: state is AuthenticatedState,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.darkGreen,
                    ),
                    strokeWidth: 1,
                  ),
                ),
              ],
            ),
          ),
        );
        if (state is AuthenticatedState || state is NotAuthenticatedState) {
          return (state is NotAuthenticatedState ||
                  (state is AuthenticatedState &&
                      _store.userEntity.picture.isEmpty))
              ? noProfile()
              : Container(
                  width: 32,
                  height: 32,
                  decoration: state is AuthenticatedState
                      ? BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.darkGreen,
                            width: 2,
                          ),
                        )
                      : null,
                  child: ButtonWidget(
                    backgroundColor: Colors.transparent,
                    overlayColor: Colors.transparent,
                    elevation: 0,
                    shape: const CircleBorder(),
                    action: () => state is AuthenticatedState
                        ? pushNamed(AppRoutes.authRoute + AppRoutes.loginRoute)
                        : pushNamed(AppRoutes.authRoute + AppRoutes.loginRoute),
                    child: _store.userEntity.picture.isEmpty
                        ? placeholder()
                        : ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: _store.userEntity.picture,
                              width: 32,
                              height: 32,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => placeholder(),
                              errorWidget: (context, url, error) =>
                                  placeholder(),
                            ),
                          ),
                  ),
                );
        } else {
          return placeholder();
        }
      },
    );
  }
}
