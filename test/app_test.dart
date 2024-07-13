import 'package:booky/app.dart';
import 'package:booky/app_bloc_observer.dart';
import 'package:booky/core/di/dependencies_container.dart';
import 'package:booky/core/utils/app_constants.dart';
import 'package:booky/main_development.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MyApp', () {
    setUp(() async {
      await registerDependencies(DevelopmentBuildConfig(
        apiBaseUrl: 'https://openlibrary.org/',
        coverImageBaseUrl: 'https://covers.openlibrary.org/b/',
        environment: AppEnvironment.development,
      ));
      Bloc.observer = getIt.get<AppBlocObserver>();
    });

    testWidgets('renders development MyApp', (tester) async {
      await tester.pumpWidget(const MyApp(),);
      expect(find.byType(MyApp), findsOneWidget);
    });
  });
}
