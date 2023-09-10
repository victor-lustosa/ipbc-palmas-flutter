class ResponsivityUtil{
  ResponsivityUtil._();
 static double widthDevice = 370;
static double resolutionDeviceProportion(double width, maxPercent, minPercent) {
  if(width > widthDevice){
    return maxPercent;
  } else{
    return minPercent;
  }
 }
}