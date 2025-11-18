import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';

class ResponsivityUtil<T> {
  static double smallDeviceWidth = 390;

  final T? df;
  final T? sm;
  final T? md;
  final T? xl;

  const ResponsivityUtil._internal({
    this.df,
    this.sm,
    this.md,
    this.xl,
  });

  factory ResponsivityUtil({
    dynamic df,
    dynamic sm,
    dynamic md,
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
        md: (md as num?)?.toDouble(),
        xl: (xl as num?)?.toDouble(),
      ) as ResponsivityUtil<T>;
    }

    return ResponsivityUtil._internal(
      df: df as T?,
      sm: sm as T?,
      md: md as T?,
      xl: xl as T?,
    );
  }

  T get(BuildContext context) {
    if (df != null) {
      return df!;
    }

    final T mValue = md ?? sm!;
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
