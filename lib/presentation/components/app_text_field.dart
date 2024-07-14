import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_colors.dart';
import '../theme/text_style.dart';

class AppTextField extends StatelessWidget {
  final String label;
  final String? initialValue;
  final Function(String value) onChanged;
  final int? maxLine;
  final int? minLine;
  final TextInputType? keyboardType;
  final String? Function(String? value)? validator;
  const AppTextField({
    super.key,
    required  this.label,
    required this.onChanged,
    this.maxLine,
    this.minLine,
    this.keyboardType,
    this.initialValue,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLine,
      minLines: minLine,
      keyboardType: keyboardType,
      initialValue: initialValue,
      validator: validator,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 16.w,),
        counter: const SizedBox.shrink(),
        floatingLabelAlignment: FloatingLabelAlignment.start,
        floatingLabelStyle: AppTextStyle.style.copyWith(color: AppColors.primary,),
        focusColor: AppColors.primary,
        hoverColor: AppColors.primary,
        iconColor: AppColors.primary,
        labelText: label,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.grey30, width: 1.r,),
          borderRadius: BorderRadius.circular(10.r),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.grey30, width: 1.r,),
          borderRadius: BorderRadius.circular(10.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary, width: 1.r,),
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
      cursorColor: AppColors.primary,
      onChanged: onChanged,
    );
  }
}
