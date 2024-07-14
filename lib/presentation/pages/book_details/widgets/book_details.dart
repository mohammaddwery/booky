import 'package:booky/presentation/theme/text_style.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../data/models/book.dart';
import '../../../theme/app_colors.dart';

class BookDetails extends StatelessWidget {
  final Book book;
  const BookDetails(this.book, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            16.verticalSpace,
            ClipRRect(
              borderRadius: BorderRadius.circular(16.r,),
              child: CachedNetworkImage(
                key: const Key('BookCover_CachedNetworkImage'),
                imageUrl: book.cover,
                height: .6.sh,
                width: double.infinity,
                errorWidget: (context, url, error) => Container(color: AppColors.error.withOpacity(.5), height: .6.sh, width: double.infinity,),
                placeholder: (context, url) => Container(color: AppColors.grey30, height: .6.sh, width: double.infinity,),
                fit: BoxFit.cover,
              ),
            ),
            24.verticalSpace,
            Text(
              key: const Key('BookTitle_Text'),
              book.title,
              style: AppTextStyle.style.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
                fontSize: 20.sp,
                height: 1.2,
              ),
            ),
            16.verticalSpace,
            Text(
              key: const Key('BookDescription_Text'),
              book.description??book.subject??'',
              style: AppTextStyle.style.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
                height: 1.3,
              ),
            ),
            24.verticalSpace,
            Container(
              decoration: BoxDecoration(
                color: AppColors.primary15,
                borderRadius: BorderRadius.circular(10.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h,),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          key: const Key('BookAuthor_Text'),
                          book.authorName,
                          style: AppTextStyle.style.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                  8.verticalSpace,
                  Text(
                    key: const Key('BookFirstPublishDate_Text'),
                    book.formattedPublishDate,
                    style: AppTextStyle.style.copyWith(
                      color: AppColors.grey90,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ),
            48.verticalSpace,
          ],
        ),
      ),
    );
  }
}
