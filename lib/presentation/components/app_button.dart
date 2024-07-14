import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_colors.dart';
import '../theme/text_style.dart';

class AppButton extends StatelessWidget {
  final Color? color;
  final String title;
  final TextStyle? textStyle;
  final double? width;
  final double? height;
  final VoidCallback onClicked;
  const AppButton({
    super.key,
    required this.onClicked,
    required this.title,
    this.color,
    this.textStyle,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: onClicked,
        child: Container(
          width: width,
          height: height,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color??AppColors.primary,
            borderRadius: BorderRadius.circular(16.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h,),
          child: Text(
            title,
            style: textStyle??AppTextStyle.style.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 16.sp,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
