import 'dart:math';

import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class AccountCreatedSuccessfullyView extends StatefulWidget {
  const AccountCreatedSuccessfullyView({super.key});

  @override
  State<AccountCreatedSuccessfullyView> createState() =>
      _AccountCreatedSuccessfullyViewState();
}

class _AccountCreatedSuccessfullyViewState
    extends State<AccountCreatedSuccessfullyView>
    with TickerProviderStateMixin {

  late final AnimationController _controller;

  late final Animation<double> _circleAnimation;
  late final Animation<double> _checkAnimation;
  late final Animation<double> _textFadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );

    _circleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
      ),
    );

    _checkAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 0.8, curve: Curves.easeOut),
      ),
    );

    _textFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 1.0, curve: Curves.easeIn),
      ),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return SizedBox(
              width: context.sizeOf.width,
              height: context.sizeOf.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 28, left: 16),
                        child:  BackButtonWidget(action: (){
                          popUntil(
                                (route) =>
                            route.settings.name ==
                                AppRoutes.authRoute + AppRoutes.loginRoute,
                          );
                        }),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: context.sizeOf.width * .4),
                    width: 70.7,
                    height: 70.7,
                    child: CustomPaint(
                      painter: CheckPainter(
                        circleProgress: _circleAnimation.value,
                        checkProgress: _checkAnimation.value,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Opacity(
                    opacity: _textFadeAnimation.value,
                    child: Column(
                      children: [
                        Text(
                          "Conta Criada com Sucesso!",
                          style: AppFonts.defaultFont(
                            color: AppColors.grey10,
                            fontSize: 22,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 16),
                          width: context.sizeOf.width * .8,
                          child: Text(
                            'Agora verifique seu e-mail para confirmação, e em seguida poderá fazer login.',
                            textAlign: TextAlign.center,
                            style: AppFonts.defaultFont(
                              color: AppColors.grey7,
                              fontSize: 19,
                            ),
                          ),
                        ),
                      ],
                    )
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class CheckPainter extends CustomPainter {
  final double circleProgress;
  final double checkProgress;

  CheckPainter({required this.circleProgress, required this.checkProgress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.darkGreen
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 6.6;

    canvas.drawArc(
      Rect.fromLTWH(0, 0, size.width, size.height),
      -pi / 2,
      2 * pi * circleProgress,
      false,
      paint,
    );

    if (checkProgress > 0) {
      final path = Path();

      path.moveTo(size.width * 0.25, size.height * 0.5);
      path.lineTo(size.width * 0.42, size.height * 0.69);
      path.lineTo(size.width * 0.78, size.height * 0.3);

      // Pega as métricas do caminho para "cortá-lo"
      final pathMetrics = path.computeMetrics();
      final metric = pathMetrics.first;

      // Extrai uma porção do caminho com base no progresso da animação
      final animatedPath = metric.extractPath(0, metric.length * checkProgress);

      canvas.drawPath(animatedPath, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // Repinta sempre que a animação mudar
  }
}
