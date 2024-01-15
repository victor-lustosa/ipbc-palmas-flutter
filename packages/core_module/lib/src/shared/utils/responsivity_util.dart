import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';

class ResponsivityUtil{
  ResponsivityUtil._();
 static double smallDeviceWidth = 370;

 static isSmallDevice(BuildContext context){
  double vWidth = context.mediaQuery.size.width;
   return ResponsivityUtil.smallDeviceWidth >= vWidth;
 }

static double resolutionDeviceProportion(double width, maxPercent, minPercent) {
  if(width > smallDeviceWidth){
    return maxPercent;
  } else{
    return minPercent;
  }
 }
}