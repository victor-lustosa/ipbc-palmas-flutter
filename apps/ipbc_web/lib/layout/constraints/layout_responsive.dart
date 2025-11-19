class TopBarResponsive {
  static double leftWidth(double value) {
    return value > 1200 ? value * 0.085 : value * 0.031;
  }

  static double rightWidth(double value) {
    return value > 1200 ? value * 0.092 : value * 0.048;
  }
}
