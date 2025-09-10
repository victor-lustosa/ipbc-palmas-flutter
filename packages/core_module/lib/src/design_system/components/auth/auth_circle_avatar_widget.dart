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
  final GlobalKey _avatarKey = GlobalKey();
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController.unbounded(vsync: this)
      ..repeat(min: -0.5, max: 1.5, period: const Duration(milliseconds: 1200));
  }

  @override
  dispose() {
    _shimmerController.dispose();
    _removeLogoutMenu();
    super.dispose();
  }

  void _removeLogoutMenu() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _showLogoutMenu() {
    if (_overlayEntry != null) {
      _removeLogoutMenu();
      return;
    }

    final RenderBox renderBox =
        _avatarKey.currentContext!.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          top: offset.dy + size.height + 8,
          left: offset.dx + size.width - 83,
          child: Material(
            color: AppColors.white,
            elevation: 4.0,
            shadowColor: Colors.black38,
            borderRadius: BorderRadius.circular(4.0),
            child: InkWell(
              onTap: () {
                _store.logout();
                _removeLogoutMenu();
              },
              borderRadius: BorderRadius.circular(4.0),
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
          ),
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry!);
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
              : Container(
                  key: _avatarKey,
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.darkGreen, width: 2),
                  ),
                  child: Material(
                    shape: const CircleBorder(),
                    clipBehavior: Clip.hardEdge,
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: _showLogoutMenu,
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
                  ),
                );
        } else {
          return placeholder();
        }
      },
    );
  }
}
