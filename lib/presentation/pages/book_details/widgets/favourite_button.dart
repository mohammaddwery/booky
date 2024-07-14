import 'package:booky/presentation/pages/book_details/cubit/favourite_book_state.dart';
import 'package:booky/repository/books_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../cubit/favourite_book_cubit.dart';

class FavouriteButton extends StatelessWidget {
  final String workId;
  const FavouriteButton(this.workId, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavouriteBookCubit(context.read<BooksRepository>())..initState(workId),
      child: buildButton(workId),
    );
  }

  Widget buildButton(String workId) {
    return BlocBuilder<FavouriteBookCubit, FavouriteBookState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () => context.read<FavouriteBookCubit>().toggleFavourite(workId),
          child: Container(
            padding: REdgeInsets.all(10.0),
            margin: const EdgeInsets.only(right: 8,),
            child: Icon(
              state.status ? Icons.star_rounded: Icons.star_border_rounded,
              color: state.status ? Colors.yellow : Colors.grey,
              size: 30.r,
            ),
          ),
        );
      },
    );
  }
}
