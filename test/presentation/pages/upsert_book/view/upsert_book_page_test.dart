import 'package:bloc_test/bloc_test.dart';
import 'package:booky/app_bloc_observer.dart';
import 'package:booky/core/di/dependencies_container.dart';
import 'package:booky/core/utils/app_constants.dart';
import 'package:booky/data/models/user_book.dart';
import 'package:booky/main_development.dart';
import 'package:booky/presentation/pages/upsert_book/bloc/upsert_book_bloc.dart';
import 'package:booky/presentation/pages/upsert_book/bloc/upsert_book_event.dart';
import 'package:booky/presentation/pages/upsert_book/bloc/upsert_book_state.dart';
import 'package:booky/presentation/pages/upsert_book/view/upsert_book_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../app_test.dart';

class MockUpsertBookBloc extends MockBloc<UpsertBookEvent, UpsertBookState>
    implements UpsertBookBloc {}
class MockSharedPreferences extends Mock implements SharedPreferences {}


void main() {
  late UpsertBookBloc upsertBookBloc;
  late SharedPreferences sharePreferences;
  late UserBook book;

  setUpAll(() async {
    sharePreferences = MockSharedPreferences();
    await registerDependencies(DevelopmentBuildConfig(
      apiBaseUrl: 'https://openlibrary.org/',
      coverImageBaseUrl: 'https://covers.openlibrary.org/b/',
      environment: AppEnvironment.development,
    ), sharePreferences);
    Bloc.observer = getIt.get<AppBlocObserver>();
  });

  setUp(() {
    upsertBookBloc = MockUpsertBookBloc();
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

    when(() => upsertBookBloc.state).thenReturn(const UpsertBookState(),);
  });

  group('UpsertBookPage', () {
    testWidgets('renders UpsertBookView', (tester) async {
      await tester.pumpApp(const UpsertBookPage());
      await tester.pumpAndSettle();

      expect(find.byType(UpsertBookView), findsOneWidget);
    });
  });

  group('UpsertBookView', () {
    testWidgets('renders AppBar_Key', (tester) async {
      await tester.pumpApp(BlocProvider.value(
        value: upsertBookBloc,
        child: const UpsertBookView(1),
      ));
      await tester.pump();

      expect(find.byKey(const Key('AppBar_Key')), findsOneWidget);
    });

    testWidgets('renders BookTitle_AppTextField', (tester) async {
      await tester.pumpApp(BlocProvider.value(
        value: upsertBookBloc,
        child: const UpsertBookView(1),
      ));
      await tester.pump();

      expect(find.byKey(const Key('BookTitle_AppTextField')), findsOneWidget);
    });

    testWidgets('renders BookAuthor_AppTextField', (tester) async {
      await tester.pumpApp(BlocProvider.value(
        value: upsertBookBloc,
        child: const UpsertBookView(1),
      ));
      await tester.pump();

      expect(find.byKey(const Key('BookAuthor_AppTextField')), findsOneWidget);
    });

    testWidgets('renders BookDescription_AppTextField', (tester) async {
      await tester.pumpApp(BlocProvider.value(
        value: upsertBookBloc,
        child: const UpsertBookView(1),
      ));
      await tester.pump();

      expect(find.byKey(const Key('BookDescription_AppTextField')), findsOneWidget);
    });

    testWidgets('renders BookPublishDate_DatePicker', (tester) async {
      await tester.pumpApp(BlocProvider.value(
        value: upsertBookBloc,
        child: const UpsertBookView(1),
      ));
      await tester.pump();

      expect(find.byKey(const Key('BookPublishDate_DatePicker')), findsOneWidget);
    });

    testWidgets('renders UpsertBook_AppButton', (tester) async {
      await tester.pumpApp(BlocProvider.value(
        value: upsertBookBloc,
        child: const UpsertBookView(1),
      ));
      await tester.pump();

      expect(find.byKey(const Key('UpsertBook_AppButton')), findsOneWidget);
    });
  });

  group('Form fields interactions', () {
    testWidgets('when BookTitle_AppTextField changes add BookTitleChanged to UpsertBookBloc', (tester) async {
      const title = 'The book title is a new title.';

      await tester.pumpApp(
        BlocProvider.value(
          value: upsertBookBloc,
          child: const UpsertBookView(1),
        ),
      );

      await tester.enterText(
        find.byKey(const Key('BookTitle_AppTextField')),
        title,
      );

      verify(() => upsertBookBloc.add(const BookTitleChanged(title))).called(1);
    });
    testWidgets('when BookAuthor_AppTextField changes add BookAuthorChanged to UpsertBookBloc', (tester) async {
      const author = 'The name of the author.';

      await tester.pumpApp(
        BlocProvider.value(
          value: upsertBookBloc,
          child: const UpsertBookView(1),
        ),
      );

      await tester.enterText(
        find.byKey(const Key('BookAuthor_AppTextField')),
        author,
      );

      verify(() => upsertBookBloc.add(const BookAuthorChanged(author))).called(1);
    });
    testWidgets('when BookDescription_AppTextField changes add BookDescriptionChanged to UpsertBookBloc', (tester) async {
      const description = 'This is similar to "flutter test", but instead of hosting the tests in the '
          'flutter environment it hosts the tests in a pure Dart environment.'
          ' The main differences are that the "dart:ui" library is not available '
          'and that tests run faster. This is helpful for testing libraries that do not '
          'depend on any packages from the Flutter SDK.';

      await tester.pumpApp(
        BlocProvider.value(
          value: upsertBookBloc,
          child: const UpsertBookView(1),
        ),
      );

      await tester.enterText(
        find.byKey(const Key('BookDescription_AppTextField')),
        description,
      );

      verify(() => upsertBookBloc.add(const BookDescriptionChanged(description))).called(1);
    });
  });
}