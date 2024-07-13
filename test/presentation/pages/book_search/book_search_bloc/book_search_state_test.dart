import 'package:booky/data/models/book.dart';
import 'package:booky/presentation/pages/book_search/bloc/book_search_state.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeBooks extends Fake implements List<Book> {}

void main() {
  group('BookSearchState', () {

    group('supports value comparisons', () {
      test('SearchStateEmpty', () {
        expect(
          SearchStateEmpty(),
          equals(SearchStateEmpty()),
        );
      });
      test('SearchStateLoading', () {
        expect(
          SearchStateLoading(),
          equals(SearchStateLoading()),
        );
      });
      test('SearchStateError', () {
        expect(
          const SearchStateError('something_went_wrong'),
          equals(const SearchStateError('something_went_wrong')),
        );
      });
      test('SearchStateSuccess', () {
        final books = FakeBooks();
        expect(
          SearchStateSuccess(books),
          equals(SearchStateSuccess(books)),
        );
      });
    });
  });
}