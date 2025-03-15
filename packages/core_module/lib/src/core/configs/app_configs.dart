import 'package:flutter/material.dart';

extension BuildContextExtensions on BuildContext {
  Rect? get globalPaintBounds {
    final renderObject = findRenderObject();
    final translation = renderObject?.getTransformTo(null).getTranslation();
    if (translation != null && renderObject?.paintBounds != null) {
      final offset = Offset(translation.x, translation.y);
      return renderObject!.paintBounds.shift(offset);
    } else {
      return null;
    }
  }

  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  ColorScheme get colorScheme => theme.colorScheme;

  DefaultTextStyle get defaultTextStyle => DefaultTextStyle.of(this);

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  Orientation get orientationOf => MediaQuery.orientationOf(this);

  Size get sizeOf => MediaQuery.sizeOf(this);

  FocusScopeNode get focusScope => FocusScope.of(this);

  ScaffoldState get scaffold => Scaffold.of(this);

  ScaffoldMessengerState get scaffoldMessenger => ScaffoldMessenger.of(this);
}

extension WidgetStateHelpers on Iterable<WidgetState> {
  bool get isHovered => contains(WidgetState.hovered);

  bool get isFocused => contains(WidgetState.focused);

  bool get isPressed => contains(WidgetState.pressed);

  bool get isDragged => contains(WidgetState.dragged);

  bool get isSelected => contains(WidgetState.selected);

  bool get isScrolledUnder => contains(WidgetState.scrolledUnder);

  bool get isDisabled => contains(WidgetState.disabled);

  bool get isError => contains(WidgetState.error);
}

/*
extension ThemeDataExtensions on ThemeData {
  AppColorsExtension get appColors =>
      extension<AppColorsExtension>() ?? lightAppColors;
}*/
