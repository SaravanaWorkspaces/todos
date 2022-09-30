
import 'package:flutter/material.dart';

const PrimaryColor = Color(0xFF2196F3);
const SecondaryColor = Color(0xFF90CAF9);
const PrimaryColorDark = Color(0xFF0D47A1);

class AppTheme {

  static final ThemeData defaultTheme = _buildTheme();

  static ThemeData _buildTheme() {
    final ThemeData base = ThemeData.light();

    return base.copyWith(
      primaryColor: PrimaryColor,
      primaryColorDark: PrimaryColorDark,
    );
  }
}