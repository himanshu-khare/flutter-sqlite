import 'package:flutter/material.dart';
import 'package:fluttersqlite/core/app_export.dart';

class AppDecoration {
  static BoxDecoration get outlineBlack => BoxDecoration(
        color: appTheme.blueGray333,
        boxShadow: [
          BoxShadow(
            color: appTheme.black77,
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: Offset(
              0,
              4,
            ),
          ),
        ],
      );
  
  static BoxDecoration get outlineWhite => BoxDecoration(
        color: appTheme.red700,
        border: Border.all(
          color: appTheme.white,
          width: 1.h,
        ),
      );
}

class BorderRadiusStyle {
  static BorderRadius get roundedBorder25 => BorderRadius.circular(
        25.h,
      );
  static BorderRadius get roundedBorder29 => BorderRadius.circular(
        29.h,
      );
}


