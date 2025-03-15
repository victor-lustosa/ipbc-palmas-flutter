class TopBarResponsive {
  static double leftWidth(value) {
    return value > 1200 ? value * 0.085 : value * 0.031;
  }

  static double rightWidth(value) {
    return value > 1200 ? value * 0.092 : value * 0.048;
  }
}
