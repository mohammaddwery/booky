import 'package:booky/data/models/book.dart';
import 'package:booky/presentation/pages/book_details/cubit/book_details_state.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeBook extends Fake implements Book {}

void main() {
  group('BookDetailsState', () {

    group('supports value comparisons', () {
      test('BookLoading', () {
        expect(
          BookLoading(),
          equals(BookLoading()),
        );
      });
      test('BookError', () {
        expect(
          const BookError('something_went_wrong'),
          equals(const BookError('something_went_wrong')),
        );
      });
      test('BookSuccess', () {
        final book = FakeBook();
        expect(
          BookSuccess(book),
          equals(BookSuccess(book)),
        );
      });
    });
  });
}