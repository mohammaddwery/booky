import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../data/models/book.dart';
import 'book_card.dart';

class BooksResultsListing extends StatelessWidget {
  final List<Book> books;
  const BooksResultsListing(this.books, {super.key});

  @override
  Widget build(BuildContext context) {
    final itemCount = books.length;
    return ListView.separated(
      padding: EdgeInsets.zero,
      itemCount: itemCount,
      separatorBuilder: (context, index) => 12.verticalSpace,
      itemBuilder: (context, index) => Column(
        children: [
          if(index == 0) 16.verticalSpace,
          BookCard(books[index]),
          if(index == itemCount-1) 100.verticalSpace,
        ],
      ),
    );
  }
}
