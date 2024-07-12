// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    BookSearchRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const BookSearchPage(),
      );
    }
  };
}

/// generated route for
/// [BookSearchPage]
class BookSearchRoute extends PageRouteInfo<void> {
  const BookSearchRoute({List<PageRouteInfo>? children})
      : super(
          BookSearchRoute.name,
          initialChildren: children,
        );

  static const String name = 'BookSearchRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
