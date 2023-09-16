import 'package:flutter/material.dart';

class SizeConfig{
  static late MediaQueryData mediaQueryData;
  static late double width;
  static late double height;
  static late double widthBlock;
  static late double heightBlock;

  static void init(BuildContext context){
    mediaQueryData = MediaQuery.of(context);
    width = mediaQueryData.size.width;
    height = mediaQueryData.size.height;
    widthBlock = width/100;
    heightBlock = height/100;
  }
}

class ThemeColors {
  static final ColorScheme lightScheme = ColorScheme.fromSeed(seedColor: Colors.blue, brightness: Brightness.light);
  static final ColorScheme darkScheme = ColorScheme.fromSeed(seedColor: Colors.blue, brightness: Brightness.dark);
}

