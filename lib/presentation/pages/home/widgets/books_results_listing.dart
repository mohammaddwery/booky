import 'package:booky/presentation/pages/home/widgets/book_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BooksResultsListing extends StatelessWidget {
  const BooksResultsListing({super.key});

  @override
  Widget build(BuildContext context) {
    const itemCount = 10;
    return ListView.separated(
      padding: EdgeInsets.zero,
      itemCount: itemCount,
      separatorBuilder: (context, index) => 12.verticalSpace,
      itemBuilder: (context, index) => Column(
        children: [
          if(index == 0) 16.verticalSpace,
          const BookCard(),
          if(index == itemCount-1) 32.verticalSpace,
        ],
      ),
    );
  }
}
