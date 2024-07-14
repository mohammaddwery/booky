import 'package:booky/core/utils/app_helpers.dart';
import 'package:booky/repository/user_book.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/text_style.dart';

class MyBookCard extends StatelessWidget {
  final UserBook book;
  const MyBookCard(this.book, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w,),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h,),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: AppColors.primary15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  book.title,
                  style: AppTextStyle.style.copyWith(
                    color: AppColors.primary,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          8.verticalSpace,
          Text(
            book.description,
            style: AppTextStyle.style.copyWith(
              color: AppColors.primary,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              height: 1.2,
            ),
          ),
          24.verticalSpace,
          Text(
            key: const Key('BookAuthor_Text'),
            book.author,
            style: AppTextStyle.style.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
            ),
          ),
          4.verticalSpace,
          Text(
            key: const Key('BookFirstPublishDate_Text'),
            book.publish.format,
            style: AppTextStyle.style.copyWith(
              color: AppColors.grey90,
              fontWeight: FontWeight.w500,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }
}
