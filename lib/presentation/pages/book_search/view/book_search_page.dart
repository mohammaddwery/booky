import 'package:auto_route/auto_route.dart';
import 'package:booky/presentation/components/app_button.dart';
import 'package:booky/presentation/pages/book_search/bloc/book_search_bloc.dart';
import 'package:booky/presentation/pages/book_search/bloc/book_search_event.dart';
import 'package:booky/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../repository/books_repository.dart';
import '../../../routes/app_router.dart';
import '../widgets/books_search_box.dart';
import '../widgets/books_search_result.dart';

@RoutePage()
class BookSearchPage extends StatelessWidget {
  const BookSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookSearchBloc(
        context.read<BooksRepository>(),
      )..add(const BooksRequested()),
      child: const BookSearchView(),
    );
  }
}

class BookSearchView extends StatelessWidget {
  const BookSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            16.verticalSpace,
            const BooksSearchBox(),
            const BooksSearchResults(),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        children: [
          16.horizontalSpace,
          Expanded(
            child: AppButton(
              height: 56.h,
              onClicked: () {
                context.pushRoute(UpsertBookRoute());
              },
              title: 'Add book',
            ),
          ),
          8.horizontalSpace,
          GestureDetector(
            onTap: () => context.navigateTo(const MyBooksRoute()),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.primary15,
                borderRadius: BorderRadius.circular(16.r),
              ),
                padding: REdgeInsets.all(10),
                child: Icon(Icons.bookmark_rounded, color: AppColors.primary, size: 36.r,),
            ),
          ),
          16.horizontalSpace,
        ],
      ),
    );
  }
}

