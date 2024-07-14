import 'package:bloc_test/bloc_test.dart';
import 'package:booky/core/data/remote/app_exceptions.dart';
import 'package:booky/data/models/book.dart';
import 'package:booky/presentation/pages/book_details/cubit/book_details_cubit.dart';
import 'package:booky/presentation/pages/book_details/cubit/book_details_state.dart';
import 'package:booky/repository/books_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockBooksRepository extends Mock implements BooksRepository {}
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
  group('BookDetailsCubit', () {
    late BooksRepository booksRepository;
    late InternetConnectionErrorException internetConnectionErrorException;
    late MockUnexpectedErrorException unexpectedErrorException;
    late Book book;

    setUpAll(() {
      book = const Book(workId: 'workId', authorName: 'authorName', title: 'title');
      booksRepository = MockBooksRepository();
      internetConnectionErrorException = MockInternetConnectionErrorException('no_internet_connection');
      unexpectedErrorException = MockUnexpectedErrorException('sorry_something_went_wrong');
    });

    group('fetchBook()', () {
      blocTest<BookDetailsCubit, BookDetailsState>(
        'emits [BookLoading, BookSuccess] when getBook() succeeds.',
        setUp: () => when(() => booksRepository.getBook('workId',)).thenAnswer((_) async => book,),
        build: () => BookDetailsCubit(booksRepository),
        act: (bloc) => bloc.fetchBook('workId', 'authorName'),
        expect: () => <BookDetailsState>[
          BookLoading(),
          BookSuccess(book,),
        ],
      );

      blocTest<BookDetailsCubit, BookDetailsState>(
        'emits [BookLoading, BookError] when getBook() gets InternetConnectionErrorException',
        setUp: () => when(() => booksRepository.getBook('workId',)).thenThrow(internetConnectionErrorException,),
        build: () => BookDetailsCubit(booksRepository),
        act: (bloc) => bloc.fetchBook('workId', 'authorName'),
        expect: () => <BookDetailsState>[
          BookLoading(),
          BookError(internetConnectionErrorException.message),
        ],
      );

      blocTest<BookDetailsCubit, BookDetailsState>(
        'emits [BookLoading, BookError] when getBook() gets UnexpectedErrorException',
        setUp: () => when(() => booksRepository.getBook('workId',)).thenThrow(unexpectedErrorException),
        build: () => BookDetailsCubit(booksRepository),
        act: (bloc) => bloc.fetchBook('workId', 'authorName'),
        expect: () => <BookDetailsState>[
          BookLoading(),
          BookError(unexpectedErrorException.message),
        ],
      );
    });
  });
}