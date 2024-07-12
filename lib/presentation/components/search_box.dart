import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_colors.dart';
import '../theme/text_style.dart';

class SearchBox extends StatelessWidget {
  final Function(String value) onChanged;
  const SearchBox({required this.onChanged, super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      maxLines: 1,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: 'Search for something',
          contentPadding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w,),
          counter: const SizedBox.shrink(),
          floatingLabelAlignment: FloatingLabelAlignment.start,
          floatingLabelStyle: AppTextStyle.style.copyWith(color: AppColors.primary,),
          focusColor: AppColors.primary,
          hoverColor: AppColors.primary,
          iconColor: AppColors.primary,
          suffixIcon: const Icon(Icons.search_rounded,),
          suffixIconColor: AppColors.primary,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.accent, width: 1.r,),
            borderRadius: BorderRadius.circular(16.r),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primary60, width: 1.r,),
            borderRadius: BorderRadius.circular(16.r),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primary, width: 1.r,),
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
    );
  }
}
