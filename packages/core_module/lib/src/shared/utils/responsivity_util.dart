class ResponsivityUtil{
  ResponsivityUtil._();
 static double smallDeviceWidth = 370;
static double resolutionDeviceProportion(double width, maxPercent, minPercent) {
  if(width > smallDeviceWidth){
    return maxPercent;
  } else{
    return minPercent;
  }
 }
}