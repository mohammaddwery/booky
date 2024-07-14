import 'package:bloc_test/bloc_test.dart';
import 'package:booky/app_bloc_observer.dart';
import 'package:booky/core/di/dependencies_container.dart';
import 'package:booky/core/utils/app_constants.dart';
import 'package:booky/data/models/book.dart';
import 'package:booky/main_development.dart';
import 'package:booky/presentation/components/error_placeholder.dart';
import 'package:booky/presentation/components/loading.dart';
import 'package:booky/presentation/pages/book_details/cubit/book_details_cubit.dart';
import 'package:booky/presentation/pages/book_details/cubit/book_details_state.dart';
import 'package:booky/presentation/pages/book_details/view/book_details_page.dart';
import 'package:booky/presentation/pages/book_details/widgets/book_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import '../../../../app_test.dart';

class MockBookDetailsCubit extends MockCubit<BookDetailsState>
    implements BookDetailsCubit {}

void main() {
  late BookDetailsCubit bookCubit;
  late Book book;

  setUpAll(() async {
    await registerDependencies(DevelopmentBuildConfig(
      apiBaseUrl: 'https://openlibrary.org/',
      coverImageBaseUrl: 'https://covers.openlibrary.org/b/',
      environment: AppEnvironment.development,
    ));
    Bloc.observer = getIt.get<AppBlocObserver>();
  });

  setUp(() {
    bookCubit = MockBookDetailsCubit();
    book = const Book(workId: 'workId', authorName: 'authorName', title: 'title', firstSentence: 'firstSentence');

    when(() => bookCubit.state).thenReturn(BookLoading(),);
  });

  group('BookDetailsPage', () {
    testWidgets('renders BookDetailsPage', (tester) async {
      await tester.pumpApp(const BookDetailsPage(
        workId: 'workId',
        author: 'author',
      ));
      await tester.pumpAndSettle();

      expect(find.byType(BookDetailsView), findsOneWidget);
    });
  });

  group('BookDetails states', () {
    testWidgets('renders BookLoading widget', (tester) async {
      when(() => bookCubit.state).thenReturn(BookLoading(),);

      await tester.pumpApp(BlocProvider.value(
        value: bookCubit,
        child: const BookDetailsView(
          workId: 'workId',
          author: 'author',
        ),
      ));
      await tester.pump();

      expect(find.byType(Loading), findsOneWidget);
    });

    testWidgets('renders BookSuccess widget and verifies that fetchBook() called', (tester) async {
      when(() => bookCubit.state).thenReturn(BookSuccess(book),);

      await mockNetworkImages(() async => await tester.pumpApp(BlocProvider.value(
        value: bookCubit..fetchBook('workId', 'author'),
        child: const BookDetailsView(
          workId: 'workId',
          author: 'author',
        ),
      )));
      await tester.pump();

      expect(find.byType(BookDetails), findsOneWidget);
      verify(() => bookCubit.fetchBook('workId', 'author')).called(1);
    });

    testWidgets('renders BookSuccess widget and verify that book\'s cover rendered', (tester) async {
      when(() => bookCubit.state).thenReturn(BookSuccess(book),);
      await mockNetworkImages(() async => await tester.pumpApp(BlocProvider.value(
        value: bookCubit..fetchBook('workId', 'author'),
        child: const BookDetailsView(
          workId: 'workId',
          author: 'author',
        ),
      )));
      await tester.pump();

      expect(find.byKey(const Key('BookCover_CachedNetworkImage')), findsOneWidget);
    });
    
    testWidgets('renders BookSuccess widget and verify that book\'s title rendered', (tester) async {
      when(() => bookCubit.state).thenReturn(BookSuccess(book),);
      await mockNetworkImages(() async => await tester.pumpApp(BlocProvider.value(
        value: bookCubit..fetchBook('workId', 'author'),
        child: const BookDetailsView(
          workId: 'workId',
          author: 'author',
        ),
      )));
      await tester.pump();

      expect(find.byKey(const Key('BookTitle_Text')), findsOneWidget);
    });
    
    testWidgets('renders BookSuccess widget and verify that book\'s description rendered', (tester) async {
      when(() => bookCubit.state).thenReturn(BookSuccess(book),);
      await mockNetworkImages(() async => await tester.pumpApp(BlocProvider.value(
        value: bookCubit..fetchBook('workId', 'author'),
        child: const BookDetailsView(
          workId: 'workId',
          author: 'author',
        ),
      )));
      await tester.pump();

      expect(find.byKey(const Key('BookDescription_Text')), findsOneWidget);
    });
    
    testWidgets('renders BookSuccess widget and verify that book\'s author and publish date rendered', (tester) async {
      when(() => bookCubit.state).thenReturn(BookSuccess(book),);
      await mockNetworkImages(() async => await tester.pumpApp(BlocProvider.value(
        value: bookCubit..fetchBook('workId', 'author'),
        child: const BookDetailsView(
          workId: 'workId',
          author: 'author',
        ),
      )));
      await tester.pump();

      expect(find.byKey(const Key('BookAuthor_Text')), findsOneWidget);
      expect(find.byKey(const Key('BookFirstPublishDate_Text')), findsOneWidget);
    });

    testWidgets('renders BookError widget', (tester) async {
      when(() => bookCubit.state).thenReturn(const BookError('something_went_wrong'),);

      await mockNetworkImages(() async => await tester.pumpApp(BlocProvider.value(
        value: bookCubit..fetchBook('workId', 'author'),
        child: const BookDetailsView(
          workId: 'workId',
          author: 'author',
        ),
      )));
      await tester.pump();

      expect(find.byType(ErrorPlaceholder), findsOneWidget);
    });

    testWidgets('renders BookError widget then clicks reload to fetchBook()', (tester) async {
      when(() => bookCubit.state).thenReturn(const BookError('something_went_wrong'),);
      await mockNetworkImages(() async => await tester.pumpApp(BlocProvider.value(
        value: bookCubit,
        child: const BookDetailsView(
          workId: 'workId',
          author: 'author',
        ),
      )));
      await tester.pump();

      await tester.tap(find.byKey(const Key('RetryIconButton')),);
      verify(() => bookCubit.fetchBook('workId', 'author')).called(1);
    });
  });


}