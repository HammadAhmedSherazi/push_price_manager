import 'dart:math';

import 'package:flutter/material.dart';

import 'responsive.dart';

/// MediaQuery-based sizing (replaces flutter_screenutil).
/// Call [update] from [MaterialApp.builder] before layout/theme access.
class ResponsiveScope {
  ResponsiveScope._();

  static Size _screenSize = const Size(360, 690);

  static void update(BuildContext context) {
    _screenSize = MediaQuery.sizeOf(context);
  }

  static Size get screenSize => _screenSize;

  static bool get isTablet =>
      _screenSize.shortestSide >= Responsive.tabletBreakpoint;

  static bool get isLargeTablet =>
      _screenSize.shortestSide >= Responsive.largeTabletBreakpoint;

  static double get _widthScale =>
      _screenSize.width / Responsive.designWidth;

  static double get _heightScale =>
      _screenSize.height / Responsive.designHeight;

  /// Fonts, images, icons — scale with screen size (readable on all devices).
  static double get _visualScale {
    if (!isTablet) {
      return _screenSize.width / Responsive.designWidth;
    }
    return sqrt(_screenSize.shortestSide / Responsive.designWidth);
  }

  static double w(num value) => value.toDouble() * _widthScale;

  static double h(num value) => value.toDouble() * _heightScale;

  static double r(num value) => w(value);

  static double sp(num value) => value.toDouble() * _visualScale;

  static double iw(num value) => value.toDouble() * _visualScale;

  static double ih(num value) => value.toDouble() * _visualScale;
}

/// Drop-in replacements for flutter_screenutil extensions.
extension ResponsiveNum on num {
  double get w => ResponsiveScope.w(this);

  double get h => ResponsiveScope.h(this);

  double get r => ResponsiveScope.r(this);

  double get sp => ResponsiveScope.sp(this);

  double get iw => ResponsiveScope.iw(this);

  double get ih => ResponsiveScope.ih(this);

  SizedBox get verticalSpace => SizedBox(height: h);

  SizedBox get horizontalSpace => SizedBox(width: w);
}
