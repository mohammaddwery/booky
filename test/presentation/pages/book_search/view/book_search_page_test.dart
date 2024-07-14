import 'package:bloc_test/bloc_test.dart';
import 'package:booky/app_bloc_observer.dart';
import 'package:booky/core/di/dependencies_container.dart';
import 'package:booky/core/utils/app_constants.dart';
import 'package:booky/data/models/book.dart';
import 'package:booky/main_development.dart';
import 'package:booky/presentation/components/error_placeholder.dart';
import 'package:booky/presentation/components/loading.dart';
import 'package:booky/presentation/components/no_results_placeholder.dart';
import 'package:booky/presentation/pages/book_search/bloc/book_search_bloc.dart';
import 'package:booky/presentation/pages/book_search/bloc/book_search_event.dart';
import 'package:booky/presentation/pages/book_search/bloc/book_search_state.dart';
import 'package:booky/presentation/pages/book_search/view/book_search_page.dart';
import 'package:booky/presentation/pages/book_search/widgets/book_card.dart';
import 'package:booky/presentation/pages/book_search/widgets/books_results_listing.dart';
import 'package:booky/presentation/pages/book_search/widgets/books_search_box.dart';
import 'package:booky/presentation/pages/book_search/widgets/books_search_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../../../app_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';


class MockSearchBloc extends MockBloc<BookSearchEvent, BookSearchState>
    implements BookSearchBloc {}

void main() {
  late BookSearchBloc searchBloc;
  late List<Book> books;

  setUpAll(() async {
    await registerDependencies(DevelopmentBuildConfig(
      apiBaseUrl: 'https://openlibrary.org/',
      coverImageBaseUrl: 'https://covers.openlibrary.org/b/',
      environment: AppEnvironment.development,
    ));
    Bloc.observer = getIt.get<AppBlocObserver>();
  });

  setUp(() {
    searchBloc = MockSearchBloc();
    books = [
      const Book(workId: 'workId', authorName: 'authorName', title: 'title', firstSentence: 'firstSentence'),
    ];

    when(() => searchBloc.state).thenReturn(SearchStateLoading(),);
  });

  group('BookSearchPage', () {
    testWidgets('renders BookSearchPage', (tester) async {
      await tester.pumpApp(const BookSearchPage());
      await tester.pumpAndSettle();

      expect(find.byType(BookSearchView), findsOneWidget);
    });
  });

  group('BookSearchView', () {
    testWidgets('renders BooksSearchBox', (tester) async {
      await tester.pumpApp(BlocProvider.value(
        value: searchBloc,
        child: const BookSearchView(),
      ));
      await tester.pump();

      expect(find.byType(BooksSearchBox), findsOneWidget);
    });

    testWidgets('renders BooksSearchResults', (tester) async {
      await tester.pumpApp(BlocProvider.value(
        value: searchBloc,
        child: const BookSearchView(),
      ));
      await tester.pump();

      expect(find.byType(BooksSearchResults), findsOneWidget);
    });
  });

  group('BooksSearchResults states', () {
    testWidgets('renders SearchStateLoading widget', (tester) async {
      when(() => searchBloc.state).thenReturn(SearchStateLoading(),);

      await tester.pumpApp(BlocProvider.value(
        value: searchBloc,
        child: const BookSearchView(),
      ));
      await tester.pump();

      expect(find.byType(Loading), findsOneWidget);
    });

    testWidgets('renders SearchStateEmpty widget', (tester) async {
      when(() => searchBloc.state).thenReturn(SearchStateEmpty(),);

      await tester.pumpApp(BlocProvider.value(
        value: searchBloc,
        child: const BookSearchView(),
      ));
      await tester.pump();

      expect(find.byType(NoResultsPlaceholder), findsOneWidget);
    });

    testWidgets('renders SearchStateSuccess widget and verifies that BooksRequested triggered', (tester) async {
      when(() => searchBloc.state).thenReturn(SearchStateSuccess(books),);

      await mockNetworkImages(() async => await tester.pumpApp(BlocProvider.value(
        value: searchBloc..add(const BooksRequested()),
        child: const BookSearchView(),
      )));
      await tester.pump();

      expect(find.byType(BooksResultsListing), findsOneWidget);
      verify(() => searchBloc.add(const BooksRequested())).called(1);
    });

    testWidgets('renders SearchStateSuccess widget and verify that book\'s card rendered', (tester) async {
      when(() => searchBloc.state).thenReturn(SearchStateSuccess(books),);

      await mockNetworkImages(() async => await tester.pumpApp(BlocProvider.value(
        value: searchBloc,
        child: const BookSearchView(),
      )));
      await tester.pump();

      expect(find.byType(BookCard), findsOneWidget);
    });

    testWidgets('renders SearchStateError widget', (tester) async {
      when(() => searchBloc.state).thenReturn(const SearchStateError('something_went_wrong'),);

      await tester.pumpApp(BlocProvider.value(
        value: searchBloc,
        child: const BookSearchView(),
      ));
      await tester.pump();

      expect(find.byType(ErrorPlaceholder), findsOneWidget);
    });

    testWidgets('renders SearchStateError widget then clicks reload to add BooksRequested to BookSearchBloc', (tester) async {
      when(() => searchBloc.state).thenReturn(const SearchStateError('something_went_wrong'),);

      await tester.pumpApp(
        BlocProvider.value(
          value: searchBloc,
          child: const BookSearchView(),
        ),
      );

      await tester.tap(find.byKey(const Key('RetryIconButton')),);
      verify(() => searchBloc.add(const BooksRequested())).called(1);
    });
  });

  group('on KeywordChanged triggered', () {
    testWidgets('when booksSearchBox changes add KeywordChanged to BookSearchBloc', (tester) async {
      await tester.pumpApp(
        BlocProvider.value(
          value: searchBloc,
          child: const BookSearchView(),
        ),
      );

      await tester.enterText(
        find.byKey(const Key('SearchBoxKey')),
        'test',
      );

      verify(() => searchBloc.add(const KeywordChanged(keyword: 'test'))).called(1);
    });
  });
}



