import 'package:flutter/material.dart';

class ShimmerWidget extends AnimatedWidget {
  final Widget? child;

  const ShimmerWidget({
    super.key,
    required Animation<double> animation,
    this.child,
  }) : super(listenable: animation);

  static const _shimmerGradient = LinearGradient(
    colors: [Color(0xFFEBEBF4), Color(0xFFF4F4F4), Color(0xFFEBEBF4)],
    stops: [0.1, 0.3, 0.4],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
    tileMode: TileMode.clamp,
  );

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (bounds) {
        return _shimmerGradient.createShader(
          Rect.fromLTWH(
            -bounds.width * animation.value,
            0,
            bounds.width * 3,
            bounds.height,
          ),
        );
      },
      child: child);
  }
}

class SlidingGradientTransform extends GradientTransform {
  const SlidingGradientTransform({required this.slidePercent});

  final double slidePercent;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * slidePercent, 0.0, 0.0);
  }
}
