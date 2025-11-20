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

  final MenuController _menuController = MenuController();

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController.unbounded(vsync: this)
      ..repeat(min: -.5, max: 1.5, period: const Duration(milliseconds: 1200));
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
      builder: (_, state, _) {

        Widget placeholder() => ShimmerWidget(
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

        void handleOnTap() {
          if (state is AuthenticatedState ||
              (state is AuthenticatedState && _store.userEntity.picture.isEmpty)) {
            // Se autenticado, abre ou fecha o menu
            if (_menuController.isOpen) {
              _menuController.close();
            } else {
              _menuController.open();
            }
          } else if (state is NotAuthenticatedState) {
            // Se não autenticado, navega
            pushNamed(AppRoutes.authRoute + AppRoutes.loginRoute);
          }
        }

        if (!(state is AuthenticatedState ||
            state is NotAuthenticatedState ||
            state is LoadingState)) {
          return placeholder();
        }

        return MenuAnchor(
          controller: _menuController,
          alignmentOffset: const Offset(-51, 5),
          style: MenuStyle(
            backgroundColor: WidgetStateProperty.all(AppColors.white),
            elevation: WidgetStateProperty.all(4),
            shadowColor: WidgetStateProperty.all(Colors.black38),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            padding: WidgetStateProperty.all(EdgeInsets.zero), // Remove padding padrão
          ),
          menuChildren: [
            InkWell(
              onTap: () {
                _store.logout();
                _menuController.close();
              },
              child: SizedBox(
                width: 83,
                height: 44,
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
                      margin: const EdgeInsets.only(left: 8),
                      child: IconWidget(
                        iconFormat: IconFormat.svg,
                        size: const Size(16, 16),
                        iconName: AppIcons.logoutSvg,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
          builder: (context, controller, child) {
            return Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: state is AuthenticatedState
                      ? AppColors.darkGreen
                      : Colors.transparent,
                  width: _store.userEntity.picture.isEmpty ? 1.2 : 1.5,
                ),
              ),
              child: InkWell(
                onTap: handleOnTap,
                borderRadius: BorderRadius.circular(32),
                child: (state is LoadingState || _store.userEntity.picture.isEmpty)
                    ? Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(AppIcons.noProfile),
                    Visibility(
                      visible: state is LoadingState,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.darkGreen,
                        ),
                        strokeWidth: 1.3,
                      ),
                    ),
                  ],
                )
                    : ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: _store.userEntity.picture,
                    width: 32,
                    height: 32,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => placeholder(),
                    errorWidget: (context, url, error) => placeholder(),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}