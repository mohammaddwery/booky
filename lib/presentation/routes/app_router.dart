import 'package:auto_route/auto_route.dart';

import '../pages/book_search/view/book_search_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: BookSearchRoute.page, path: '/',),
  ];
}