// lib/utils/responsive.dart
import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const Responsive({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  });

  // Screen size breakpoints
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 650;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 650 &&
      MediaQuery.of(context).size.width < 1100;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    
    if (size.width >= 1100) {
      return desktop;
    } else if (size.width >= 650) {
      return tablet ?? mobile;
    } else {
      return mobile;
    }
  }
}

// Extension on BuildContext for easy access
extension ResponsiveExtension on BuildContext {
  // Screen size checks
  bool get isMobile => MediaQuery.of(this).size.width < 650;
  bool get isTablet => MediaQuery.of(this).size.width >= 650 && MediaQuery.of(this).size.width < 1100;
  bool get isDesktop => MediaQuery.of(this).size.width >= 1100;
  
  // Screen dimensions
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
  
  // Responsive padding
  double get horizontalPadding => isMobile ? 16.0 : (isTablet ? 24.0 : 32.0);
  double get verticalPadding => isMobile ? 16.0 : (isTablet ? 20.0 : 24.0);
  
  // Responsive font sizes
  double get headingFontSize => isMobile ? 24 : (isTablet ? 28 : 32);
  double get subheadingFontSize => isMobile ? 18 : (isTablet ? 20 : 22);
  double get bodyFontSize => isMobile ? 14 : (isTablet ? 15 : 16);
  double get smallFontSize => isMobile ? 12 : (isTablet ? 13 : 14);
  
  // Responsive grid columns
  int get gridColumnCount => isMobile ? 1 : (isTablet ? 2 : 4);
  
  // Responsive spacing
  double get spacingSmall => isMobile ? 8 : 12;
  double get spacingMedium => isMobile ? 16 : 24;
  double get spacingLarge => isMobile ? 24 : 32;
  double get spacingXLarge => isMobile ? 32 : 40;
  
  // Responsive image heights
  double get heroHeight => isMobile ? 300 : (isTablet ? 350 : 400);
  double get productImageHeight => isMobile ? 150 : (isTablet ? 150 : 180);
}