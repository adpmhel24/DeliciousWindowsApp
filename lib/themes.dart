import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppTheme {
  static textTheme() {
    return GoogleFonts.merriweatherTextTheme().copyWith(
      headline1: TextStyle(
        fontSize: 90.sp,
        fontFamily: GoogleFonts.merriweather().fontFamily,
      ),
      headline2: TextStyle(
        fontSize: 60.sp,
        fontFamily: GoogleFonts.merriweather().fontFamily,
      ),
      headline3: TextStyle(
        fontSize: 48.sp,
        fontFamily: GoogleFonts.merriweather().fontFamily,
        color: const Color(0xff323232),
      ),
      headline4: TextStyle(
        fontSize: 34.sp,
        fontFamily: GoogleFonts.merriweather().fontFamily,
        color: const Color(0xff323232),
      ),
      headline5: TextStyle(
        fontSize: 25.sp,
        fontFamily: GoogleFonts.merriweather().fontFamily,
        color: const Color(0xff323232),
      ),
      headline6: TextStyle(
        fontSize: 20.sp,
        fontFamily: GoogleFonts.merriweather().fontFamily,
        color: const Color(0xff323232),
      ),
      subtitle1: TextStyle(
        fontSize: 16.sp,
        fontFamily: GoogleFonts.merriweather().fontFamily,
        color: const Color(0xff323232),
      ),
      subtitle2: TextStyle(
        fontSize: 14.sp,
        fontFamily: GoogleFonts.merriweather().fontFamily,
        color: const Color(0xff323232),
      ),
      bodyText1: TextStyle(
        fontSize: 16.sp,
        fontFamily: GoogleFonts.merriweather().fontFamily,
        color: const Color(0xff323232),
      ),
      bodyText2: TextStyle(
        fontSize: 14.sp,
        fontFamily: GoogleFonts.merriweather().fontFamily,
        color: const Color(0xff323232),
      ),
      button: TextStyle(
        fontSize: 14.sp,
        fontFamily: GoogleFonts.merriweather().fontFamily,
        color: const Color(0xff323232),
      ),
      caption: TextStyle(
        fontSize: 12.sp,
        fontFamily: GoogleFonts.merriweather().fontFamily,
        color: const Color(0xff323232),
      ),
      overline: TextStyle(
        fontSize: 10.sp,
        fontFamily: GoogleFonts.merriweather().fontFamily,
        color: const Color(0xff323232),
      ),
    );
  }
}
