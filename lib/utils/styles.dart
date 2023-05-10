import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pif_flutter/extensions/context_extensions.dart';
import 'package:pif_flutter/utils/colors.dart';

class Style {
  static const _pageTransitionTheme = PageTransitionsTheme(
    builders: {
      TargetPlatform.android: ZoomPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder()
    },
  );

  static final defaultTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryColor,
    pageTransitionsTheme: _pageTransitionTheme,
    scaffoldBackgroundColor: whiteColor,
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
      ),
    ),
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: primaryColor,
      background: whiteColor,
      surface: whiteColor,
      onBackground: primaryColor,
      onSurface: primaryColor,
      secondary: primaryColor,
      error: Colors.red,
      onError: Colors.white,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
    ).copyWith(background: whiteColor),
  );

  static TextStyle commonTextStyle({
    required Color? color,
    required double? fontSize,
    required FontWeight? fontWeight,
    double? letterSpacing,
    double? height,
  }) {
    final textStyle = GoogleFonts.poppins(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
    );
    return textStyle;
  }

  static InputDecoration inputDecoration({
    String? text,
    Widget? suffixIcon,
    Color? fillColor,
    Color? hintColor,
    double? hintFontSize = 16,
    Widget? prefixIcon,
  }) {
    const inputBorder = OutlineInputBorder(
      borderSide: BorderSide.none,
    );

    return InputDecoration(
      isDense: true,
      fillColor: fillColor ?? Colors.transparent,
      hintText: text ?? '',
      hintStyle: Style.commonTextStyle(
        color: hintColor ?? primaryColor,
        fontSize: hintFontSize?.sp,
        fontWeight: FontWeight.w400,
      ),
      contentPadding: EdgeInsets.zero,
      focusedBorder: inputBorder,
      border: inputBorder,
      suffixIcon: suffixIcon,
      prefixIcon: prefixIcon,
    );
  }

  static ButtonStyle primaryButtonStyle({required BuildContext context}) {
    return ElevatedButton.styleFrom(
      elevation: 0,
      fixedSize: Size(context.screenWidth.w, 45.h),
      foregroundColor: whiteColor,
      backgroundColor: primaryColor,
      textStyle: Style.commonTextStyle(
        color: whiteColor,
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
