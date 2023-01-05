import 'package:flutter/material.dart';
import 'package:dependencies/google_fonts/google_fonts.dart';

class ColorName {
  ColorName._();

  static const Color whiteColor = Color(0xffFFFFFF);
  static const Color blackColor = Color(0xff14193F);
  static const Color greyColor = Color(0xffA4A8AE);
  static const Color lightGreyColor = Color(0xffF1F1F9);
  static const Color lightBackgroundColor = Color(0xffF6F8FB);
  static const Color lightSelectedColor = Color(0xFFE4E4E4);
  static const Color darkBackgroundColor = Color(0xff020518);
  static const Color blueColor = Color(0xff53C1F9);
  static Color purpleColor = (Colors.purple).shade900;
  static const Color greenColor = Color(0xff22B07D);
  static const Color numberBackgroundColor = Color(0xff1A1D2E);
  static Color redColor = (Colors.red).shade900;
}

class BaseText {
  BaseText._();

  static TextStyle blackTextStyle = GoogleFonts.dmSans(
    color: ColorName.blackColor,
  );

  static TextStyle appTextStyle = GoogleFonts.poppins(
    color: ColorName.redColor,
  );

  static TextStyle whiteTextStyle = GoogleFonts.poppins(
    color: ColorName.whiteColor,
  );

  static TextStyle greyTextStyle = GoogleFonts.poppins(
    color: ColorName.greyColor,
  );

  static TextStyle blueTextStyle = GoogleFonts.poppins(
    color: ColorName.blueColor,
  );

  static TextStyle greenTextStyle = GoogleFonts.dmSans(
    color: ColorName.greenColor,
  );

  static FontWeight light = FontWeight.w300;
  static FontWeight regular = FontWeight.w400;
  static FontWeight medium = FontWeight.w500;
  static FontWeight semiBold = FontWeight.w600;
  static FontWeight bold = FontWeight.w700;
  static FontWeight extraBold = FontWeight.w800;
  static FontWeight black = FontWeight.w900;
}
