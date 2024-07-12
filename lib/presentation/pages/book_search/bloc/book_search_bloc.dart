import 'package:stream_transform/stream_transform.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/models/book.dart';
import 'book_search_event.dart';
import 'book_search_state.dart';

const _duration = Duration(milliseconds: 500);

/// transformer to reduce search attempts which is optimizing search experience
EventTransformer<Event> debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

class BookSearchBloc extends Bloc<BookSearchEvent, BookSearchState> {
  BookSearchBloc() : super(SearchStateLoading()) {
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
    emit(SearchStateLoading());
    await Future.delayed(const Duration(seconds: 2,));
    _books = List<Book>.from(Book.books);
    if(_books.isEmpty) return emit(SearchStateEmpty());

    return emit(SearchStateSuccess(_books));
  }

  /// Search functionality is working locally on books that fetched once app opened
  Future<void> _onKeywordChanged(
      KeywordChanged event,
      Emitter<BookSearchState> emit,
  ) async {
    if(_books.isEmpty) return emit(SearchStateEmpty());

    final keyword = event.keyword;

    if (keyword.isEmpty) return emit(SearchStateSuccess(_books));

    emit(SearchStateLoading());
    /// to give better user experience only.
    await Future.delayed(const Duration(seconds: 1,));

    final books = _books.filterBooksByAuthorAndTitle(keyword);
    if(books.isEmpty) return emit(SearchStateEmpty());

    return emit(SearchStateSuccess(books));
  }
}
