
import 'package:booky/presentation/pages/book_search/bloc/book_search_event.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BookSearchEvent', () {
    group('BooksRequested', () {
      test('supports value comparisons', () {
        const event1 = BooksRequested();
        const event2 = BooksRequested();

        expect(event1, equals(event2));
      });
    });

    group('KeywordChanged', () {
      test('supports value comparisons', () {
        const event1 = KeywordChanged(keyword: 'Lord');
        const event2 = KeywordChanged(keyword: 'Lord');

        expect(event1, equals(event2));
      });
    });
  });
}