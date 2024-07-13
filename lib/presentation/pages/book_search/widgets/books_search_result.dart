import 'package:booky/presentation/pages/book_search/bloc/book_search_event.dart';
import 'package:booky/presentation/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../components/custom_error.dart';
import '../../../components/loading.dart';
import '../bloc/book_search_bloc.dart';
import '../bloc/book_search_state.dart';
import 'books_results_listing.dart';

class BooksSearchResults extends StatelessWidget {
  const BooksSearchResults({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () {
          context.read<BookSearchBloc>().add(const BooksRequested());
          return Future.value();
        },
        child: BlocBuilder<BookSearchBloc, BookSearchState>(
          builder: (context, state) {
            return switch (state) {
            SearchStateEmpty() => const NoResultsPlaceholder(),
            SearchStateLoading() => const Loading(),
            SearchStateError() => Error(state.error),
            SearchStateSuccess() => BooksResultsListing(state.books),
            };
          },
        ),
      ),
    );
  }
}

class NoResultsPlaceholder extends StatelessWidget {
  const NoResultsPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CustomError(message: 'Sorry no books found!!'));
  }
}

class Error extends StatelessWidget {
  final String message;
  const Error(this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: CustomError(
      message: message,
      textStyle: AppTextStyle.errorStateStyle,
      onRetryClicked: () => context.read<BookSearchBloc>().add(const BooksRequested()),
    ));
  }
}





