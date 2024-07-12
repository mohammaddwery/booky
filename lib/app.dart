
import 'package:booky/presentation/routes/app_router.dart';
import 'package:booky/presentation/theme/app_colors.dart';
import 'package:booky/presentation/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatelessWidget {
  final _appRouter = AppRouter();
  MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: _appRouter.config(),
          themeMode: ThemeMode.light,
          theme: ThemeData.light().copyWith(
            textTheme: Theme.of(context)
                .textTheme
                .apply(fontFamily: fontFamily),
            scaffoldBackgroundColor: AppColors.accent,
          ),
        );
      },
    );
  }
}