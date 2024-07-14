import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../pages/book_details/view/book_details_page.dart';
import '../pages/book_search/view/book_search_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: BookSearchRoute.page, path: '/',),
    AutoRoute(page: BookDetailsRoute.page,),
  ];
}