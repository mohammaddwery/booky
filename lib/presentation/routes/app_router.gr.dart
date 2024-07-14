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
    BookDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<BookDetailsRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: BookDetailsPage(
          workId: args.workId,
          author: args.author,
          key: args.key,
        ),
      );
    },
    BookSearchRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const BookSearchPage(),
      );
    },
  };
}

/// generated route for
/// [BookDetailsPage]
class BookDetailsRoute extends PageRouteInfo<BookDetailsRouteArgs> {
  BookDetailsRoute({
    required String workId,
    required String author,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          BookDetailsRoute.name,
          args: BookDetailsRouteArgs(
            workId: workId,
            author: author,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'BookDetailsRoute';

  static const PageInfo<BookDetailsRouteArgs> page =
      PageInfo<BookDetailsRouteArgs>(name);
}

class BookDetailsRouteArgs {
  const BookDetailsRouteArgs({
    required this.workId,
    required this.author,
    this.key,
  });

  final String workId;

  final String author;

  final Key? key;

  @override
  String toString() {
    return 'BookDetailsRouteArgs{workId: $workId, author: $author, key: $key}';
  }
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
