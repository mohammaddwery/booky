import 'package:bloc_test/bloc_test.dart';
import 'package:booky/presentation/pages/book_details/cubit/favourite_book_cubit.dart';
import 'package:booky/presentation/pages/book_details/cubit/favourite_book_state.dart';
import 'package:booky/repository/books_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockBooksRepository extends Mock implements BooksRepository {
  @override
  Future addFavoriteBook(String workId) async => [];

  @override
  Future removeFavoriteBook(String workId) async => [];
}

main() {
  group('FavouriteBookCubit', () {
    late BooksRepository booksRepository;

    setUpAll(() {
      booksRepository = MockBooksRepository();
    });

    blocTest<FavouriteBookCubit, FavouriteBookState>(
      'emits [FavouriteBookState] with true value when getFavoriteBooks() contains the same book.',
      setUp: () => when(() => booksRepository.getFavoriteBooks()).thenAnswer((_) => [ 'workId' ],),
      build: () => FavouriteBookCubit(booksRepository),
      act: (bloc) => bloc.initState('workId'),
      expect: () => <FavouriteBookState>[
        const FavouriteBookState(true),
      ],
    );

    blocTest<FavouriteBookCubit, FavouriteBookState>(
      'emits [FavouriteBookState] with false value when getFavoriteBooks() doesn\'t contain the same book.',
      setUp: () => when(() => booksRepository.getFavoriteBooks()).thenAnswer((_) => [ ],),
      build: () => FavouriteBookCubit(booksRepository),
      act: (bloc) => bloc.initState('workId'),
      expect: () => <FavouriteBookState>[
        const FavouriteBookState(false),
      ],
    );

    blocTest<FavouriteBookCubit, FavouriteBookState>(
      'emits [FavouriteBookState] with true value after adding a new book to favourite list.',
      setUp: () => when(() => booksRepository.getFavoriteBooks()).thenAnswer((_) => [ ],),
      build: () => FavouriteBookCubit(booksRepository),
      act: (bloc) => bloc.toggleFavourite('workId'),
      expect: () => <FavouriteBookState>[
        const FavouriteBookState(true),
      ],
    );

    blocTest<FavouriteBookCubit, FavouriteBookState>(
      'emits [FavouriteBookState] with false value after removing a book from favourite list.',
      setUp: () => when(() => booksRepository.getFavoriteBooks()).thenAnswer((_) => ['workId'],),
      build: () => FavouriteBookCubit(booksRepository)..initState('workId'),
      act: (bloc) => bloc.toggleFavourite('workId'),
      expect: () => <FavouriteBookState>[
        const FavouriteBookState(false),
      ],
    );
  });
}