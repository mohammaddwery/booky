import 'package:booky/presentation/routes/app_router.dart';
import 'package:booky/presentation/theme/app_colors.dart';
import 'package:booky/presentation/theme/text_style.dart';
import 'package:booky/repository/books_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/di/dependencies_container.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key,});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: getIt.get<BooksRepository>(),
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: getIt.get<AppRouter>().config(),
            themeMode: ThemeMode.light,
            theme: ThemeData.light().copyWith(
              textTheme: Theme.of(context)
                  .textTheme
                  .apply(fontFamily: fontFamily),
              scaffoldBackgroundColor: AppColors.accent,
            ),
          );
        },
      ),
    );
  }
}