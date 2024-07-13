import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_bloc_observer.dart';
import 'core/di/dependencies_container.dart';
import 'core/utils/build_config.dart';

Future<void> bootstrap({
  required Widget Function() appBuilder,
  required BuildConfig buildConfig,
}) async {
  await runZonedGuarded<Future<void>>(
        () async {
      WidgetsFlutterBinding.ensureInitialized();
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);

      /// Make sure that all needed app's dependencies are registered
      await registerDependencies(buildConfig);
      Bloc.observer = getIt.get<AppBlocObserver>();

      runApp(appBuilder());
    },
        (_, __) {},
  );
}