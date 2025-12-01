import 'dart:async';

import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

enum ToastType { success, error, warning }

OverlayEntry? _currentOverlayEntry;

void showCustomToast({
  required BuildContext context,
  required String title,
  Alignment? alignment,
  double? width,
  required String message,
  Duration? duration,
  Function()? onDelayedAction,
  ToastType? type = ToastType.success,
}) async {
  if (_currentOverlayEntry != null) {
    _currentOverlayEntry!.remove();
    _currentOverlayEntry = null;
  }

  final OverlayState overlayState = Overlay.of(context);

  _currentOverlayEntry = OverlayEntry(
    builder: (context) {
      return ToastAnimation(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: ToastWidget(
            title: title,
            message: message,
            type: type!,
            alignment: alignment,
            width: width,
            onDelayedAction: onDelayedAction,
          ),
        ),
      );
    },
  );

  overlayState.insert(_currentOverlayEntry!);

  Timer(duration ?? const Duration(milliseconds: 900), () {
    Future.delayed(const Duration(milliseconds: 250), () {
      if (onDelayedAction != null) {
        onDelayedAction();
      }
      if (_currentOverlayEntry != null) {
        _currentOverlayEntry!.remove();
        _currentOverlayEntry = null;
      }
    });
  });
}

class ToastAnimation extends StatefulWidget {
  final Widget child;

  const ToastAnimation({super.key, required this.child});

  @override
  State<ToastAnimation> createState() => _ToastAnimationState();
}

class _ToastAnimationState extends State<ToastAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<Offset> _position;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _opacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    _position = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: SlideTransition(position: _position, child: widget.child),
    );
  }
}

class ToastWidget extends StatelessWidget {
  final String title;
  final String message;
  final Alignment? alignment;
  final double? width;
  final Function()? onDelayedAction;
  final ToastType type;

  const ToastWidget({
    super.key,
    required this.title,
    required this.message,
    required this.type,
    this.onDelayedAction,
    this.alignment,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    late final Color backgroundColor;
    late final Widget icon;

    switch (type) {
      case ToastType.success:
        backgroundColor = AppColors.darkGreen;
        icon = const SuccessIconWidget();
        break;
      case ToastType.error:
        backgroundColor = AppColors.modalRed;
        icon = const ErrorIconWidget();
        break;
      case ToastType.warning:
        backgroundColor = AppColors.modalWarning;
        icon = const WarningIconWidget();
        break;
    }

    return Align(
      alignment: alignment ?? Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.only(bottom: 40, left: 16, right: 16),
        child: Material(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
          clipBehavior: Clip.antiAlias,
          child: Container(
            width: width ?? context.sizeOf.width,
            constraints: const BoxConstraints(minHeight: 95),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          icon,
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  title,
                                  style: AppFonts.defaultFont(
                                    fontSize: 16,
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  message,
                                  style: AppFonts.defaultFont(
                                    fontSize: 12,
                                    color: AppColors.white,
                                  ),
                                  softWrap: true,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 16,
                      right: 16,
                      child: InkWell(
                        onTap: () {
                          if (onDelayedAction != null) {
                            onDelayedAction!();
                          }
                          if (_currentOverlayEntry != null) {
                            _currentOverlayEntry!.remove();
                            _currentOverlayEntry = null;
                          }
                        },
                        child: Image.asset(
                          AppIcons.close,
                          width: 14,
                          height: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ErrorIconWidget extends StatelessWidget {
  const ErrorIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        size: const Size(50, 50),
        painter: CircleWithXPainter(),
      ),
    );
  }
}

class CircleWithXPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint circlePaint = Paint()
      ..color = AppColors.redCircleModal
      ..style = PaintingStyle.fill;

    final Paint xPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.5;

    // Desenha o círculo
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width / 2,
      circlePaint,
    );

    // Tamanho do "X" (ajuste conforme necessário)
    double xLength = size.width / 3.5;

    // Desenha a linha diagonal da esquerda para a direita
    canvas.drawLine(
      Offset(size.width / 2 - xLength / 2, size.height / 2 - xLength / 2),
      Offset(size.width / 2 + xLength / 2, size.height / 2 + xLength / 2),
      xPaint,
    );

    // Desenha a linha diagonal da direita para a esquerda
    canvas.drawLine(
      Offset(size.width / 2 + xLength / 2, size.height / 2 - xLength / 2),
      Offset(size.width / 2 - xLength / 2, size.height / 2 + xLength / 2),
      xPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class SuccessIconWidget extends StatelessWidget {
  const SuccessIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        size: const Size(50, 50),
        painter: SuccessIconPainter(),
      ),
    );
  }
}

class SuccessIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint circlePaint = Paint()
      ..color = AppColors.greenInputAccept
      ..style = PaintingStyle.fill;

    final Paint checkPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    // Desenha o círculo
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width / 2,
      circlePaint,
    );

    // Desenha a marca de seleção (checkmark)
    Path path = Path()
      ..moveTo(size.width / 4, size.height / 2)
      ..lineTo(size.width * 0.4, size.height * 0.7)
      ..lineTo(size.width * 0.75, size.height * 0.3);

    canvas.drawPath(path, checkPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class WarningIconWidget extends StatelessWidget {
  const WarningIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.iconModalWarning,
        ),
        child: Image.asset(
          AppIcons.warningIcon,
          width: 12,
          height: 12,
          color: AppColors.white,
        ),
      ),
    );
  }
}
