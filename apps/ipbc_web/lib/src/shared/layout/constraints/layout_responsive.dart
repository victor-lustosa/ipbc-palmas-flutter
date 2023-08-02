class TopBarResponsive {

  static leftWidth(value){
    return value > 1000
        ? value * 0.085
        : value * 0.044;
  }
  static rightWidth(value){
    return value > 1000
        ? value * 0.092
        : value * 0.058;
  }
}