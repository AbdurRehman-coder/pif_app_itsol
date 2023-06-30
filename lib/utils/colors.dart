import 'dart:math';

import 'package:flutter/material.dart';

const blackColor = Color(0xFF000000);
const whiteColor = Color(0xFFFFFFFF);
const primaryColor = Color(0xFF088542);
const primaryDarkColor = Color(0xFF00652E);
const primaryDisabledColor = Color(0xFF9DDBB2);
const lightPrimaryColor = Color(0xFFE6F6EC);
const darkPrimaryColor = Color(0xFF004B34);
const textColor = Color(0xFF231F20);
const darkTextColor = Color(0xFF272627);
const borderColor = Color(0xFFC0BABC);
const hintColor = Color(0xFFA19B9D);
const grayTextColor = Color(0xFF635F60);
const lightGrayBgColor = Color(0xFFFAFAFA);
const grayBorderColor = Color(0xFFE3DEDF);
const goldenColor = Color(0xFFB37C4C);
const darkBorderColor = Color(0xFF777374);
const lightGoldenColor = Color(0xFFE7E3DA);
const silverTextColor = Color(0xFF565556);
const lineColor = Color(0xFFE6E4EA);
const redColor = Color(0xFFBF0000);
const dangerousColor = Color(0xFFEC2419);
const pinkColor = Color(0xFFFFEAEC);
const dateBgColor = Color(0xFFC4E9D0);
const dayTextColor = Color(0xFF444041);
const inactiveTrackColor = Color(0xFFF2ECED);
const grayCardBg = Color(0xFFF7F7F7);
const activeStatusColor = Color(0xFF2B663B);
const activeBgColor = Color(0xFFE6F6EC);
const loggedStatusColor = Color(0xFFB37C4C);
const loggedBgColor = Color(0xFFF1F1CD);
const expireStatusColor = Color(0xFF777374);
const expireBgColor = Color(0xFFF5F5F5);
const pendingStatusColor = Color(0xFF084B85);
const darkBlueColor = Color(0xFF0E6AA7);
const pendingBgColor = Color(0xFFE0F3FB);
const gradientStart = Color(0xFF272627);
const gradientEnd = Color(0xFFC29B5B);

// GRAY
const gray29 = Color(0xFF292929);
const gray8c = Color(0xFF8C8C8C);
const gray15 = Color(0xFF151516);
const gray33 = Color(0xFF333333);
const gray39 = Color(0xFF393939);
const gray3D = Color(0xFF3D3F43);
const gray46 = Color(0xFF464646);
const gray4D = Color(0xFF4D4D4D);
const gray55 = Color(0xFF555555);
const gray61 = Color(0xFF616161);
const gray6C = Color(0xFF6C6C6C);
const gray7A = Color(0xFF7A7A7A);
const gray85 = Color(0xFF858585);
const gray89 = Color(0xFF898989);
const gray98 = Color(0xFF989898);
const gray9E = Color(0xFF9E9E9E);
const grayA0 = Color(0xFFA0A0A0);
const grayC0 = Color(0xFFC0C0C0);
const grayD1 = Color(0xFFD1D1D1);
const grayD7 = Color(0xFFD7D7D7);
const grayD9 = Color(0xFFD9D9D9);
const grayDB = Color(0xFFDBDBDB);
const grayE3 = Color(0xFFE3E3E3);
const grayEB = Color(0xFFEBEBEB);
const grayF0 = Color(0xFFF0F0F0);
const greyDivider = Color(0xFFE9E9E9);
const grayF5 = Color(0xFFF5F5F5);
const grayF9 = Color(0xFFF9F9F9);
const gray45 = Color(0xFF45597A);

final List<Color> colorOptions = [
  primaryColor,
  darkBlueColor,
  goldenColor,
];

Color getRandomColor() {
  final random = Random();
  final index = random.nextInt(colorOptions.length);
  return colorOptions[index];
}
