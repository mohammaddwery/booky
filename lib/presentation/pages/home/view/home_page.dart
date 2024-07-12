import 'package:auto_route/auto_route.dart';
import 'package:booky/presentation/pages/home/widgets/books_search_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [

            24.verticalSpace,
            BooksSearchResults(),
          ],
        ),
      ),
    );
  }
}
