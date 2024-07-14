import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../repository/books_repository.dart';
import 'my_books_state.dart';

class MyBooksCubit extends Cubit<MyBooksState> {
  final BooksRepository _booksRepository;
  MyBooksCubit(this._booksRepository): super(const MyBooksState([]));

  getMyBooks() {
    emit(MyBooksState(_booksRepository.getUserBooks()));
  }
}