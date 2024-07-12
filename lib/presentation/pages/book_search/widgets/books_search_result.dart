import 'package:booky/presentation/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../components/custom_error.dart';
import '../bloc/book_search_bloc.dart';
import '../bloc/book_search_state.dart';
import 'books_results_listing.dart';

class BooksSearchResults extends StatelessWidget {
  const BooksSearchResults({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<BookSearchBloc, BookSearchState>(
        builder: (context, state) {
          return switch (state) {
          SearchStateEmpty() => const Center(child: CustomError(message: 'Sorry no results found!!')),
          SearchStateLoading() => const Center(child: CircularProgressIndicator.adaptive()),
          SearchStateError() => Center(child: CustomError(
            message: state.error,
            textStyle: AppTextStyle.errorStateStyle,
            onRetryClicked: () {
                // TODO
          },)),
          SearchStateSuccess() => BooksResultsListing(state.books),
          };
        },
      ),
    );
  }
}


