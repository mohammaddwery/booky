import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../repository/books_repository.dart';
import 'favourite_book_state.dart';

class FavouriteBookCubit extends Cubit<FavouriteBookState> {
  final BooksRepository _booksRepository;
  FavouriteBookCubit(this._booksRepository): super(const FavouriteBookState(false));

  initState(String workId) {
    final status = _booksRepository.getFavoriteBooks().any((element) => element == workId);

    emit(FavouriteBookState(status));
  }

  Future<void> toggleFavourite(String workId) async {
    final status = state.status;
    if(status) {
      await _booksRepository.removeFavoriteBook(workId);
    } else {
      await _booksRepository.addFavoriteBook(workId);
    }

    emit(FavouriteBookState(!status));
  }
}