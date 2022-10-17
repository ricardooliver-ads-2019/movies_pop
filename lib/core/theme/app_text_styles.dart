import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_pop/core/theme/app_colors.dart';

class AppTextStyles {
  static final titleHome = GoogleFonts.lexendDeca(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    color: AppColors.heading,
  );

  static final titleHomeM = GoogleFonts.lexendDeca(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.primary.withOpacity(0.5),
    shadows: [
      Shadow(
        color: AppColors.black.withOpacity(0.5),
        blurRadius: 0.5,
        offset: const Offset(0, 2),
      )
    ],
  );

  static final titleRegular = GoogleFonts.lexendDeca(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: AppColors.heading,
  );

  static final releaseDateCardMovies = GoogleFonts.lexendDeca(
    fontSize: 12,
    fontWeight: FontWeight.w800,
    color: AppColors.releaseDate,
  );

  static final starRating = GoogleFonts.lexendDeca(
    fontSize: 17,
    fontWeight: FontWeight.bold,
    height: 0,
    letterSpacing: 0,
    wordSpacing: 0,
    color: AppColors.secondary,
  );

  static final titleCardMovies = GoogleFonts.lexendDeca(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.thirdary,
  );

  static final titleBoldHeading = GoogleFonts.lexendDeca(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.heading,
  );
  static final titleBottonSheet = GoogleFonts.lexendDeca(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.secondary,
  );
  static final titleBotton = GoogleFonts.lexendDeca(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    color: AppColors.secondary,
  );
  static final titleBoldBackground = GoogleFonts.lexendDeca(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.background,
  );
  static final titleCardDetails = GoogleFonts.lexendDeca(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.thirdary,
  );
  static final subTitleMovieDetails = GoogleFonts.lexendDeca(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.black,
  );

  static final sinopseDescription = GoogleFonts.lexendDeca(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.black,
  );
  static final titleGenres = GoogleFonts.lexendDeca(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.thirdary,
  );
  static final runTime = GoogleFonts.lexendDeca(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.black,
  );
  static final dateY = GoogleFonts.lexendDeca(
    fontSize: 18,
    fontWeight: FontWeight.normal,
    color: AppColors.black,
  );
  static final ratingMovieDetails = GoogleFonts.lexendDeca(
    fontSize: 24,
    fontWeight: FontWeight.w500,
    color: AppColors.black,
  );
  static final trailingRegular = GoogleFonts.lexendDeca(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.heading,
  );
  static final trailingBold = GoogleFonts.lexendDeca(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.heading,
  );
  static final buttonPrimary = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.primary,
  );
  static final buttonHeading = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.heading,
  );
  static final buttonGray = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.grey,
  );
  static final buttonBackground = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.background,
  );
  static final buttonBoldPrimary = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color: AppColors.primary,
  );
  static final buttonBoldHeading = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color: AppColors.heading,
  );
  static final buttonBoldGray = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color: AppColors.grey,
  );
  static final buttonBoldBackground = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color: AppColors.background,
  );
  static final captionBackground = GoogleFonts.lexendDeca(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.background,
  );
  static final captionShape = GoogleFonts.lexendDeca(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.shape,
  );
  static final captionBody = GoogleFonts.lexendDeca(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.stroke,
  );
  static final captionBoldBackground = GoogleFonts.lexendDeca(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: AppColors.background,
  );
  static final captionBoldShape = GoogleFonts.lexendDeca(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: AppColors.shape,
  );
  static final captionBoldBody = GoogleFonts.lexendDeca(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: AppColors.stroke,
  );

  static final input = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.shimmerGrey,
  );
}
