import 'package:auto_route/auto_route.dart';
import 'package:booky/presentation/components/no_results_placeholder.dart';
import 'package:booky/repository/books_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../theme/text_style.dart';
import '../bloc/my_books_cubit.dart';
import '../bloc/my_books_state.dart';
import '../widgets/my_book_card.dart';

@RoutePage()
class MyBooksPage extends StatelessWidget {
  const MyBooksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyBooksCubit(context.read<BooksRepository>())..getMyBooks(),
      child: const MyBooksView(),
    );
  }
}

class MyBooksView extends StatelessWidget {
  const MyBooksView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Books', style: AppTextStyle.appbarTitleStyle,
        ),
      ),
      body: BlocBuilder<MyBooksCubit, MyBooksState>(
        builder: (context, state) {
          if(state.books.isEmpty) return const NoResultsPlaceholder();

          return ListView.separated(
            padding: EdgeInsets.zero,
            separatorBuilder: (context, index) => 12.verticalSpace,
            itemCount: state.books.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  if(index == 0) 16.verticalSpace,
                  MyBookCard(state.books[index]),
                  if(index == state.books.length-1) 100.verticalSpace,
                ],
              );
            },
          );
        },
      ),
    );
  }
}

