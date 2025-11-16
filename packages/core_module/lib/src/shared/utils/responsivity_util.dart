import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';

class ResponsivityUtil<T> {
  static double smallDeviceWidth = 390;

  final T? df;
  final T? sm;
  final T? m;
  final T? xl;

  const ResponsivityUtil._internal({
    this.df,
    this.sm,
    this.m,
    this.xl,
  });

  factory ResponsivityUtil({
    dynamic df,
    dynamic sm,
    dynamic m,
    dynamic xl,
  }) {
    assert(
    df != null || sm != null,
    'Você deve fornecer um valor "df" (default) OU pelo menos "sm".',
    );

    if (T == double) {
      return ResponsivityUtil._internal(
        df: (df as num?)?.toDouble(),
        sm: (sm as num?)?.toDouble(),
        m: (m as num?)?.toDouble(),
        xl: (xl as num?)?.toDouble(),
      ) as ResponsivityUtil<T>;
    }

    return ResponsivityUtil._internal(
      df: df as T?,
      sm: sm as T?,
      m: m as T?,
      xl: xl as T?,
    );
  }

  T get(BuildContext context) {
    if (df != null) {
      return df!;
    }

    final T mValue = m ?? sm!;
    final T xlValue = xl ?? mValue;

    final double screenWidth = MediaQuery.of(context).size.width;

    // Telas Grandes (XL)
    if (screenWidth > 420) {
      return xlValue;
    }

    // Telas Médias (M)
    if (screenWidth > 380) {
      return mValue;
    }

    // Telas Pequenas (SM)
    return sm!;
  }

  static isSmallDevice(BuildContext context) {
    double vWidth = context.sizeOf.width;
    return ResponsivityUtil.smallDeviceWidth >= vWidth;
  }

  static double resolutionDeviceProportion(
    double width,
    maxPercent,
    minPercent,
  ) {
    if (width > smallDeviceWidth) {
      return maxPercent;
    } else {
      return minPercent;
    }
  }
}
