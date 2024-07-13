import 'package:auto_route/auto_route.dart';
import 'package:booky/presentation/pages/book_search/bloc/book_search_bloc.dart';
import 'package:booky/presentation/pages/book_search/bloc/book_search_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/di/dependencies_container.dart';
import '../../../../repository/books_repository.dart';
import '../widgets/books_search_box.dart';
import '../widgets/books_search_result.dart';

@RoutePage()
class BookSearchPage extends StatelessWidget {
  const BookSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: getIt.get<BooksRepository>(),
      child: BlocProvider(
        create: (context) => BookSearchBloc(
          context.read<BooksRepository>(),
        )..add(const BooksRequested()),
        child: const BookSearchView(),
      ),
    );
  }
}

class BookSearchView extends StatelessWidget {
  const BookSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            16.verticalSpace,
            const BooksSearchBox(),
            const BooksSearchResults(),
          ],
        ),
      ),
    );
  }
}

