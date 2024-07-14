import 'package:booky/presentation/pages/book_details/cubit/book_details_state.dart';
import 'package:booky/repository/books_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/data/remote/app_exceptions.dart';
import '../../../../core/utils/app_logger.dart';

class BookDetailsCubit extends Cubit<BookDetailsState> {
  final BooksRepository _booksRepository;
  BookDetailsCubit(this._booksRepository,): super(BookLoading());

  void fetchBook(String workId, String author) async {
    try {
      emit(BookLoading());

      final book = await _booksRepository.getBook(workId);
      final fullBook = book.copyWith(authorName: author,);

      emit(BookSuccess(fullBook));
    } on AppException catch(e) {
      logger.e('BookDetailsCubit AppException', error: e.toString(),);
      emit(BookError(e.message));
    } catch(e) {
      logger.e('BookDetailsCubit Exception', error: e,);
      emit(const BookError('something_went_wrong'));
    }
  }
}
