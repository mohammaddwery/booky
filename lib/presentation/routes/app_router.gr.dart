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
    DummyRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const DummyPage(),
      );
    }
  };
}

/// generated route for
/// [DummyPage]
class DummyRoute extends PageRouteInfo<void> {
  const DummyRoute({List<PageRouteInfo>? children})
      : super(
          DummyRoute.name,
          initialChildren: children,
        );

  static const String name = 'DummyRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
