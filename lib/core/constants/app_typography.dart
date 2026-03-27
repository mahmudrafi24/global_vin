import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTypography {
  AppTypography._();

  // VIN display - Space Mono
  static TextStyle vinDisplay = GoogleFonts.spaceMono(
    fontSize: 18,
    letterSpacing: 3,
    color: AppColors.primary,
  );

  static TextStyle vinInput = GoogleFonts.spaceMono(
    fontSize: 16,
    letterSpacing: 2,
    color: AppColors.textPrimary,
  );

  static TextStyle vinSmall = GoogleFonts.spaceMono(
    fontSize: 12,
    letterSpacing: 1.5,
    color: AppColors.textSecondary,
  );

  static TextStyle specValue = GoogleFonts.spaceMono(
    fontSize: 14,
    color: AppColors.textPrimary,
  );

  // Headings - Inter
  static TextStyle heading1 = GoogleFonts.inter(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static TextStyle heading2 = GoogleFonts.inter(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static TextStyle heading3 = GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static TextStyle heading4 = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  // Body - Inter
  static TextStyle body = GoogleFonts.inter(
    fontSize: 14,
    color: AppColors.textSecondary,
    letterSpacing: 0.3,
  );

  static TextStyle bodyBold = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: 0.3,
  );

  static TextStyle bodySmall = GoogleFonts.inter(
    fontSize: 12,
    color: AppColors.textSecondary,
  );

  static TextStyle caption = GoogleFonts.inter(
    fontSize: 10,
    color: AppColors.textSecondary,
    letterSpacing: 0.5,
  );

  static TextStyle button = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: 0.5,
  );

  static TextStyle label = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    letterSpacing: 0.5,
  );
}
