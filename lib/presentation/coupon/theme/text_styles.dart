import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

class AppTextStyles {
  static TextStyle headerText = GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    height: 1.3,
  );

  static TextStyle applyButtonText = GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryGreen,
    height: 1.3,
  );

  static TextStyle inputText = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textGrey,
    height: 1,
  );

  static TextStyle errorText = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w300,
    color: AppColors.errorRed,
    height: 2,
  );

  static TextStyle sectionTitle = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.textGrey,
    height: 1,
  );

  static TextStyle couponCode = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.primaryGreen,
    height: 1.3,
  );

  static TextStyle couponDescription = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.lightGrey,
    height: 1,
  );

  static TextStyle moreText = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.lightGrey,
    height: 1.3,
  );
}