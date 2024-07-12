import 'package:booky/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const String fontFamily = 'RedHatDisplay';

class AppTextStyle {
  AppTextStyle._();

  static const TextStyle style = TextStyle(
    fontFamily: fontFamily,
    height: 1.0,
  );

  static TextStyle get emptyStateStyle => TextStyle(
    fontFamily: fontFamily,
    height: 1.0,
    color: AppColors.grey90,
    fontSize: 12.sp,
  );
  static TextStyle get errorStateStyle => TextStyle(
    fontFamily: fontFamily,
    height: 1.0,
    color: AppColors.error,
    fontSize: 14.sp,
  );
}