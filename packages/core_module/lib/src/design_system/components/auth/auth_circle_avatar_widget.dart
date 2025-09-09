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
  bool isLogoutButtonVisible = false;

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
                ? () {
                    setState(() {
                      isLogoutButtonVisible = !isLogoutButtonVisible;
                    });
                  }
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
              : Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
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
                        action: state is AuthenticatedState
                            ? () {
                                setState(() {
                                  isLogoutButtonVisible =
                                      !isLogoutButtonVisible;
                                });
                              }
                            : () => pushNamed(
                                AppRoutes.authRoute +
                                    AppRoutes.loginRoute,
                              ),
                        child: _store.userEntity.picture.isEmpty
                            ? placeholder()
                            : ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl: _store.userEntity.picture,
                                  width: 32,
                                  height: 32,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      placeholder(),
                                  errorWidget: (context, url, error) =>
                                      placeholder(),
                                ),
                              ),
                      ),
                    ),
                    Positioned(
                      top: 40,
                      right: 0,
                      child: Visibility(
                        visible: isLogoutButtonVisible,
                        child: Material(
                          color: AppColors.white,
                          child: Container(
                            width: 83,
                            height: 44,
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: ButtonWidget(
                              action: () async {
                                _store.logout();
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              backgroundColor: AppColors.white,
                              shadowColor: AppColors.grey0,
                              foregroundColor: AppColors.darkGreen,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Sair",
                                    style: AppFonts.defaultFont(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: AppColors.darkGreen,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 8),
                                    child: IconWidget(
                                      iconFormat: IconFormat.svg,
                                      size: Size(16, 16),
                                      iconName: AppIcons.logoutSvg,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
        } else {
          return placeholder();
        }
      },
    );
  }
}
