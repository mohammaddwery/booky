import 'package:booky/presentation/components/search_box.dart';
import 'package:booky/presentation/pages/book_search/bloc/book_search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../bloc/book_search_event.dart';

class BooksSearchBox extends StatelessWidget {
  const BooksSearchBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w,),
      child: SearchBox(
        onChanged: (value) {
          context.read<BookSearchBloc>().add(
            KeywordChanged(keyword: value),
          );
        },
      ),
    );
  }
}
