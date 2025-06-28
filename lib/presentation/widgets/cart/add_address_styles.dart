import 'package:flutter/material.dart';
import 'package:sodakkuapp/utils/constant.dart';

class AddAddressStyles {
  static Color primaryGreen = appColor;
  static const Color backgroundColor = Color(0xFFFAFAFA);
  static const Color textPrimary = Color(0xFF000000);
  static const Color textSecondary = Color(0xFF202020);
  static const Color borderColor = Color(0xFF666666);

  static const double defaultPadding = 12.0;
  static const double formSpacing = 8.0;
  static const double borderRadius = 5.0;
  static const double maxWidth = 480.0;

  static const TextStyle headerStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    fontFamily: 'Poppins',
  );

  static const TextStyle labelStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Color(0xFF666666),
    fontFamily: 'Poppins',
  );

  static const TextStyle inputStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Colors.grey,
    fontFamily: 'Poppins',
  );

  static const TextStyle locationTitleStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: textPrimary,
    fontFamily: 'Poppins',
  );

  static const TextStyle locationSubtitleStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: textSecondary,
    height: 1.3,
    fontFamily: 'Poppins',
  );

  static ButtonStyle addressLabelButtonStyle = OutlinedButton.styleFrom(
    foregroundColor: borderColor,
    side: const BorderSide(color: borderColor),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
    padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 5),
  );

  static ButtonStyle saveButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: primaryGreen,
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
    padding: const EdgeInsets.symmetric(vertical: 11),
  );
}
