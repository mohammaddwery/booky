import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_bloc_observer.dart';

Future<void> bootstrap(Widget Function() appBuilder) async {
  await runZonedGuarded<Future<void>>(
        () async {
      WidgetsFlutterBinding.ensureInitialized();

      final blocObserver = AppBlocObserver();
      Bloc.observer = blocObserver;

      runApp(appBuilder());
    },
        (_, __) {},
  );
}