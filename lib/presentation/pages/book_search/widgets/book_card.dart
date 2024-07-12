import 'package:booky/presentation/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../data/models/book.dart';
import '../../../theme/text_style.dart';

class BookCard extends StatelessWidget {
  final Book book;
  const BookCard(this.book, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: .27.sh,
      margin: EdgeInsets.symmetric(horizontal: 16.w,),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        image: DecorationImage(
          image: NetworkImage(book.cover,),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h,),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          gradient: LinearGradient(
            colors: [
              AppColors.primary.withOpacity(.35),
              AppColors.primary.withOpacity(.075),
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            stops: const [.25, 1.0],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    book.title,
                    style: AppTextStyle.style.copyWith(
                      color: AppColors.accent,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                  ),
                ),
              ],
            ),
            8.verticalSpace,
            Row(
              children: [
                Expanded(
                  child: Text(
                    book.firstSentence,
                    style: AppTextStyle.style.copyWith(
                      color: AppColors.accent,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
