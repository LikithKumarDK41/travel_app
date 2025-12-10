import 'package:flutter/material.dart';

class AppColors {
  // Gose City Brand Palette
  static const Color primaryTeal = Color(0xFF00A896);
  static const Color secondaryPink = Color(0xFFFF8FA3);
  static const Color accentYellow = Color(0xFFFFC857);
  static const Color softGreen = Color(0xFFA0E8AF);

  static const Color background = Color(0xFFFAFAFA);
  static const Color surface = Colors.white;

  static const Color textDark = Color(0xFF2D3142);
  static const Color textGrey = Color(0xFF909497);

  // Backwards Compatibility Aliases
  static const Color primaryGreen = primaryTeal;
  static const Color accentBrown = Color(
    0xFF8D6E63,
  ); // Keeping a brown for now or use textDark
  static const Color sakuraPink = secondaryPink;
}
