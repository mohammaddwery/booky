import 'package:booky/app.dart';
import 'package:booky/app_bloc_observer.dart';
import 'package:booky/core/di/dependencies_container.dart';
import 'package:booky/core/utils/app_constants.dart';
import 'package:booky/main_development.dart';
import 'package:booky/presentation/theme/app_colors.dart';
import 'package:booky/presentation/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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


extension WidgetTesterExtension on WidgetTester {
  Future<void> pumpApp(Widget widget) async => await pumpWidget(
      ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) {
          return MaterialApp(
            home: widget,
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.light,
            theme: ThemeData.light().copyWith(
              textTheme: Theme.of(context)
                  .textTheme
                  .apply(fontFamily: fontFamily),
              scaffoldBackgroundColor: AppColors.accent,
            ),
          );
        },
      )
  );
}