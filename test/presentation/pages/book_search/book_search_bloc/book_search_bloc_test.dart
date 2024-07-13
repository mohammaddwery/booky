import 'package:booky/core/data/remote/app_exceptions.dart';
import 'package:booky/data/models/book.dart';
import 'package:booky/presentation/pages/book_search/bloc/book_search_bloc.dart';
import 'package:booky/presentation/pages/book_search/bloc/book_search_event.dart';
import 'package:booky/presentation/pages/book_search/bloc/book_search_state.dart';
import 'package:booky/repository/books_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';


class MockBooksRepository extends Mock implements BooksRepository {}
class MockBook extends Mock implements Book {}
class MockInternetConnectionErrorException extends Mock implements InternetConnectionErrorException {
  @override
  final String message;
  MockInternetConnectionErrorException(this.message);
}
class MockUnexpectedErrorException extends Mock implements UnexpectedErrorException {
  @override
  final String message;
  MockUnexpectedErrorException(this.message);
}

void main() {
  group('BookSearchBloc', () {
    late BooksRepository booksRepository;
    late InternetConnectionErrorException internetConnectionErrorException;
    late MockUnexpectedErrorException unexpectedErrorException;
      late List<Book> books;

    setUpAll(() {
      books = [ MockBook() ];
      booksRepository = MockBooksRepository();
      internetConnectionErrorException = MockInternetConnectionErrorException('no_internet_connection');
      unexpectedErrorException = MockUnexpectedErrorException('sorry_something_went_wrong');
    });

    group('on BooksRequested', () {
      blocTest<BookSearchBloc, BookSearchState>(
        'emits [SearchStateLoading, SearchStateSuccess] when getBooks succeeds.',
        setUp: () => when(() => booksRepository.getBooks()).thenAnswer((_) async => books,),
        build: () => BookSearchBloc(booksRepository),
        act: (bloc) => bloc.add(const BooksRequested()),
        verify: (_)=> verify(booksRepository.getBooks).called(1),
        expect: () => <BookSearchState>[
          SearchStateLoading(),
          SearchStateSuccess(books,),
        ],
      );

      blocTest<BookSearchBloc, BookSearchState>(
        'emits [SearchStateLoading, SearchStateEmpty] when getBooks() returns empty results.',
        setUp: () => when(() => booksRepository.getBooks()).thenAnswer((_) async => [],),
        build: () => BookSearchBloc(booksRepository),
        act: (bloc) => bloc.add(const BooksRequested()),
        verify: (_)=> verify(booksRepository.getBooks).called(1),
        expect: () => <BookSearchState>[
          SearchStateLoading(),
          SearchStateEmpty(),
        ],
      );

      blocTest<BookSearchBloc, BookSearchState>(
        'emits [SearchStateLoading, SearchStateError] when getBooks() gets InternetConnectionErrorException',
        setUp: () => when(() => booksRepository.getBooks()).thenThrow(internetConnectionErrorException,),
        build: () => BookSearchBloc(booksRepository),
        act: (bloc) => bloc.add(const BooksRequested()),
        verify: (_)=> verify(booksRepository.getBooks).called(1),
        expect: () => <BookSearchState>[
          SearchStateLoading(),
          SearchStateError(internetConnectionErrorException.message),
        ],
      );

      blocTest<BookSearchBloc, BookSearchState>(
        'emits [SearchStateLoading, SearchStateError] when getBooks() gets UnexpectedErrorException',
        setUp: () => when(() => booksRepository.getBooks()).thenThrow(unexpectedErrorException,),
        build: () => BookSearchBloc(booksRepository),
        act: (bloc) => bloc.add(const BooksRequested()),
        verify: (_)=> verify(booksRepository.getBooks).called(1),
        expect: () => <BookSearchState>[
          SearchStateLoading(),
          SearchStateError(unexpectedErrorException.message),
        ],
      );
    });

    group('on KeywordChanged with empty value and triggered after awaited debounce time', () {
      blocTest<BookSearchBloc, BookSearchState>(
        'emits [SearchStateLoading, SearchStateSuccess] when books filtering get results.',
        setUp: () => when(() => booksRepository.getBooks(),).thenAnswer((_) async => books,),
        build: () => BookSearchBloc(booksRepository),
        act: (bloc) {
          bloc.add(const BooksRequested());
          bloc.add(const KeywordChanged());
        },
        wait: const Duration(milliseconds: 300),
        verify: (_)=> verify(booksRepository.getBooks).called(1),
        expect: () => <BookSearchState>[
          SearchStateLoading(),
          SearchStateSuccess(books),
        ],
      );

      blocTest<BookSearchBloc, BookSearchState>(
        'emits [SearchStateLoading, SearchStateError] with books filtering returns empty results.',
        setUp: () => when(() => booksRepository.getBooks()).thenAnswer((_) async => [],),
        build: () => BookSearchBloc(booksRepository),
        act: (bloc) {
          bloc.add(const BooksRequested());
          bloc.add(const KeywordChanged());
        },
        wait: const Duration(milliseconds: 300),
        verify: (_)=> verify(booksRepository.getBooks).called(1),
        expect: () => <BookSearchState>[
          SearchStateLoading(),
          SearchStateEmpty(),
        ],
      );
    });

    group('on KeywordChanged with value and triggered after awaited debounce time', () {
      blocTest<BookSearchBloc, BookSearchState>(
        'emits [SearchStateLoading, SearchStateSuccess] when books filtering get results.',
        setUp: () => when(() => booksRepository.getBooks(),).thenAnswer((_) async => books,),
        build: () => BookSearchBloc(booksRepository),
        act: (bloc) async {
          bloc.add(const BooksRequested());
          bloc.add(const KeywordChanged(keyword: 'lord'));
        },
        wait: const Duration(milliseconds: 300),
        expect: () => <BookSearchState>[
          SearchStateLoading(),
          SearchStateSuccess(books),
        ],
      );
    });
  });
}