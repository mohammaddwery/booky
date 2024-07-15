import 'package:bloc_test/bloc_test.dart';
import 'package:booky/data/models/user_book.dart';
import 'package:booky/presentation/pages/upsert_book/bloc/upsert_book_bloc.dart';
import 'package:booky/presentation/pages/upsert_book/bloc/upsert_book_event.dart';
import 'package:booky/presentation/pages/upsert_book/bloc/upsert_book_state.dart';
import 'package:booky/repository/books_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockBooksRepository extends Mock implements BooksRepository {}


void main() {
  group('UpsertBookBloc', () {
    late BooksRepository booksRepository;
    late UserBook book;
    late UserBook invalidTitleBook;

    setUpAll(() {
      booksRepository = MockBooksRepository();
    });

    setUp(() {
      invalidTitleBook = UserBook(
        id: DateTime.now().millisecond,
        title: 'title',
        author: 'My name now same of yesterday',
        description: 'This is similar to "flutter test", but instead of hosting the tests in the '
            'flutter environment it hosts the tests in a pure Dart environment.'
            ' The main differences are that the "dart:ui" library is not available '
            'and that tests run faster. This is helpful for testing libraries that do not '
            'depend on any packages from the Flutter SDK.',
        publish: DateTime.now().subtract(const Duration(days: 100)),
      );
      book = UserBook(
        id: DateTime.now().millisecond,
        title: 'title of my book now',
        author: 'My name now same of yesterday',
        description: 'This is similar to "flutter test", but instead of hosting the tests in the '
            'flutter environment it hosts the tests in a pure Dart environment.'
            ' The main differences are that the "dart:ui" library is not available '
            'and that tests run faster. This is helpful for testing libraries that do not '
            'depend on any packages from the Flutter SDK.',
        publish: DateTime.now().subtract(const Duration(days: 100)),
      );
    });

    group('on Field\'s values changed', () {
      blocTest<UpsertBookBloc, UpsertBookState>(
        'emits [UpsertBookState] with title value when BookTitleChanged event added.',
        build: () => UpsertBookBloc(booksRepository),
        act: (bloc) => bloc.add(const BookTitleChanged('title')),
        expect: () => <UpsertBookState>[
          const UpsertBookState(
            title: 'title',
          ),
        ],
      );
      blocTest<UpsertBookBloc, UpsertBookState>(
        'emits [UpsertBookState] with author value when BookAuthorChanged event added.',
        build: () => UpsertBookBloc(booksRepository),
        act: (bloc) => bloc.add(const BookAuthorChanged('author')),
        expect: () => <UpsertBookState>[
          const UpsertBookState(
            author: 'author',
          ),
        ],
      );
      blocTest<UpsertBookBloc, UpsertBookState>(
        'emits [UpsertBookState] with description value when BookDescriptionChanged event added.',
        build: () => UpsertBookBloc(booksRepository),
        act: (bloc) => bloc.add(const BookDescriptionChanged('description')),
        expect: () => <UpsertBookState>[
          const UpsertBookState(
            description: 'description',
          ),
        ],
      );
      blocTest<UpsertBookBloc, UpsertBookState>(
        'emits [UpsertBookState] with publish date value when BookPublishDateChanged event added.',
        build: () => UpsertBookBloc(booksRepository),
        act: (bloc) => bloc.add(BookPublishDateChanged(DateTime(2024))),
        expect: () => <UpsertBookState>[
          UpsertBookState(
            publish: DateTime(2024),
          ),
        ],
      );
    });

    group('on AddBookRequested', () {
      blocTest<UpsertBookBloc, UpsertBookState>(
        'emits [UpsertBookFailure] with validation message for title when AddBookRequested event added with invalid title value.',
        setUp: () => when(() => booksRepository.addUserBook(invalidTitleBook)).thenAnswer((_) => invalidTitleBook,),
        build: () => UpsertBookBloc(booksRepository, invalidTitleBook),
        act: (bloc) => bloc.add(AddBookRequested(invalidTitleBook)),
        expect: () => <UpsertBookState>[
          UpsertBookFailure(
            'Please keep your book\'s title between 10 and 120 characters',
            invalidTitleBook.id,
            invalidTitleBook.title,
            invalidTitleBook.author,
            invalidTitleBook.description,
            invalidTitleBook.publish,
          ),
        ],
      );

      blocTest<UpsertBookBloc, UpsertBookState>(
        'emits [AddBookSuccess] when AddBookRequested event added with valid book.',
        setUp: () => when(() => booksRepository.addUserBook(book)).thenAnswer((_) => book,),
        build: () => UpsertBookBloc(booksRepository, book),
        act: (bloc) => bloc.add(AddBookRequested(book)),
        expect: () => <UpsertBookState>[
          AddBookSuccess(),
        ],
      );
    });

    group('on UpdateBookRequested', () {
      blocTest<UpsertBookBloc, UpsertBookState>(
        'emits [UpdateBookSuccess] when UpdateBookRequested event added with valid book.',
        setUp: () => when(() => booksRepository.updateUserBook(bookId: book.id, book: book,)).thenAnswer((_) => book,),
        build: () => UpsertBookBloc(booksRepository, book),
        act: (bloc) => bloc.add(UpdateBookRequested(book.id, book,)),
        expect: () => <UpsertBookState>[
          UpdateBookSuccess(book.id),
        ],
      );

      blocTest<UpsertBookBloc, UpsertBookState>(
        'emits [UpsertBookFailure] with validation message for title when UpdateBookRequested event added with invalid title value.',
        setUp: () => when(() => booksRepository.updateUserBook(bookId: invalidTitleBook.id, book: invalidTitleBook,)).thenAnswer((_) => invalidTitleBook,),
        build: () => UpsertBookBloc(booksRepository, invalidTitleBook),
        act: (bloc) => bloc.add(UpdateBookRequested(invalidTitleBook.id, invalidTitleBook)),
        expect: () => <UpsertBookState>[
          UpsertBookFailure(
            'Please keep your book\'s title between 10 and 120 characters',
            invalidTitleBook.id,
            invalidTitleBook.title,
            invalidTitleBook.author,
            invalidTitleBook.description,
            invalidTitleBook.publish,
          ),
        ],
      );
    });
  });
}