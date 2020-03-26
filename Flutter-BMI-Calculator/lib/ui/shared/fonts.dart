import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import '../size_config.dart';
import 'colors.dart';

class AppFonts {
  /// * fontSize: 80
  /// * color: primaryColor
  static final largeFontStyle = GoogleFonts.roboto(
    color: AppColors.primaryColor,
    fontSize: SizeConfig.textMultiplier * 22.222,
    fontWeight: FontWeight.w700,
    height: 0.9,
  );

  /// * fontSize: 31
  /// * color: secondaryColor
  static final mediumFontStyle = GoogleFonts.roboto(
    color: AppColors.secondaryColor,
    fontSize: SizeConfig.textMultiplier * 8.611,
    fontWeight: FontWeight.w500,
  );

  /// * fontSize: 32
  /// * color: primaryColor
  static final mediumFontStyleV2 = GoogleFonts.roboto(
    color: AppColors.primaryColor,
    fontSize: SizeConfig.textMultiplier * 8.888,
    fontWeight: FontWeight.w500,
  );

  /// * fontSize: 15
  /// * color: subheadColor
  static final normalFontStyle = GoogleFonts.roboto(
    color: AppColors.subheadColor,
    fontSize: SizeConfig.textMultiplier * 4.166,
    fontWeight: FontWeight.bold,
  );

  /// * fontSize: 16
  /// * color: subheadColor
  static final normalFontStyleV2 = GoogleFonts.roboto(
    color: AppColors.subheadColor,
    fontSize: SizeConfig.textMultiplier * 4.444,
    fontWeight: FontWeight.bold,
  );

  /// * fontSize: 14
  /// * color: subtitleColor
  static final tinyTextStyle = GoogleFonts.roboto(
    fontSize: SizeConfig.textMultiplier * 3.888,
    color: AppColors.subtitleColor,
  );

  /// * fontSize: 14
  /// * color: genderTextColor
  static final tinyTextStyleV2 = GoogleFonts.roboto(
    fontSize: SizeConfig.textMultiplier * 3.888,
    color: AppColors.genderTextColor,
  );

  /// * fontSize: 14
  /// * color: pageControlTextColor
  static final tinyTextStyleV3 = GoogleFonts.roboto(
    fontSize: SizeConfig.textMultiplier * 3.888,
    color: AppColors.pageControlTextColor,
    fontWeight: FontWeight.w700,
  );

  /// * fontSize: 14
  /// * color: whiteColor
  static final tinyTextStyleV4 = GoogleFonts.roboto(
    fontSize: SizeConfig.textMultiplier * 3.888,
    color: Colors.white,
  );

  /// * fontSize: 14
  /// * color: subheadColor
  static final tinyTextStyleV5 = GoogleFonts.roboto(
    fontSize: SizeConfig.textMultiplier * 3.888,
    color: AppColors.subheadColor,
    fontWeight: FontWeight.w700,
  );

  /// * fontSize: 14
  /// * color: genderTextColor
  static final tinyTextStyleV6 = GoogleFonts.roboto(
    fontSize: SizeConfig.textMultiplier * 3.888,
    color: AppColors.primaryColor,
    fontWeight: FontWeight.w700,
  );
}
