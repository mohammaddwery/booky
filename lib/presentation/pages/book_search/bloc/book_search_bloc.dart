import 'package:booky/core/data/remote/app_exceptions.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_logger.dart';
import '../../../../data/models/book.dart';
import '../../../../repository/books_repository.dart';
import 'book_search_event.dart';
import 'book_search_state.dart';

const _duration = Duration(milliseconds: 500);

/// transformer to reduce search attempts which is optimizing search experience
EventTransformer<Event> debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

class BookSearchBloc extends Bloc<BookSearchEvent, BookSearchState> {
  final BooksRepository _booksRepository;
  BookSearchBloc(this._booksRepository) : super(SearchStateLoading()) {
    on<BooksRequested>(_onBooksRequested,);
    on<KeywordChanged>(_onKeywordChanged, transformer: debounce(_duration),);
  }

  /// local attribute that stores the fetched books
  /// to keep it safe when user is filtering for a book
  List<Book> _books = [];

  /// Fetch books from serverside once bloc initialised
  Future<void> _onBooksRequested(
      BooksRequested event,
      Emitter<BookSearchState> emit,
      ) async {
    try {
      emit(SearchStateLoading());

      _books = await _booksRepository.getBooks();
      if(_books.isEmpty) return emit(SearchStateEmpty());

      emit(SearchStateSuccess(_books..shuffle()));
    } on AppException catch(e) {
      logger.e('BookSearchBloc AppException', error: e.toString(),);
      emit(SearchStateError(e.message));
    } catch(e) {
      logger.e('BookSearchBloc Exception', error: e,);
      emit(const SearchStateError('something_went_wrong'));
    }
  }

  /// Search functionality is working locally on books that fetched once app opened
  Future<void> _onKeywordChanged(
      KeywordChanged event,
      Emitter<BookSearchState> emit,
  ) async {
    final keyword = event.keyword;

    if (keyword.isEmpty) {
      if(_books.isEmpty) return emit(SearchStateEmpty());

      return emit(SearchStateSuccess(_books..shuffle()));
    }

    emit(SearchStateLoading());
    /// to give better user experience only.
    await Future.delayed(const Duration(seconds: 1,));

    final books = _books.filterBooksByAuthorAndTitle(keyword);
    if(books.isEmpty) return emit(SearchStateEmpty());

    return emit(SearchStateSuccess(books..shuffle()));
  }
}
