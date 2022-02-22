import 'package:flutter/material.dart';

class Responsive {
  // This isMobile, isTablet, isDesktop helep us later
  static bool smallScreen(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return screenSize.width < 1010 && screenSize.height < 650;
  }

  static bool largeScreen(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return screenSize.width > 1280 && screenSize.height > 650;
  }
}
