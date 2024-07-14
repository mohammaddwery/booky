import 'package:auto_route/auto_route.dart';
import 'package:booky/presentation/pages/book_details/widgets/book_details.dart';
import 'package:booky/presentation/pages/book_details/widgets/favourite_button.dart';
import 'package:booky/presentation/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../repository/books_repository.dart';
import '../../../components/error_placeholder.dart';
import '../../../components/loading.dart';
import '../cubit/book_details_cubit.dart';
import '../cubit/book_details_state.dart';

@RoutePage()
class BookDetailsPage extends StatelessWidget {
  final String workId;
  final String author;
  const BookDetailsPage({
    required this.workId,
    required this.author,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookDetailsCubit(context.read<BooksRepository>())
        ..fetchBook(workId, author),
      child: BookDetailsView(workId: workId, author: author,),
    );
  }
}

class BookDetailsView extends StatelessWidget {
  final String workId;
  final String author;
  const BookDetailsView({
    required this.workId,
    required this.author,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Details', style: AppTextStyle.appbarTitleStyle,
        ),
        actions: [
          FavouriteButton(workId),
        ],
      ),
      body: BlocBuilder<BookDetailsCubit, BookDetailsState>(
        builder: (context, state) {
         return switch (state) {
            BookLoading() => const Loading(),
            BookError() => ErrorPlaceholder(
                message: state.error,
                onRetryClicked: () => context.read<BookDetailsCubit>().fetchBook(workId, author),
              ),
            BookSuccess() => BookDetails(state.book),
          };
        },
      ),
    );
  }
}

