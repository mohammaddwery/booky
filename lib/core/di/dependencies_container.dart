import 'package:booky/core/data/remote/api_manager.dart';
import 'package:booky/core/data/remote/dio_api_manger.dart';
import 'package:booky/core/utils/build_config.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../../app_bloc_observer.dart';
import '../../presentation/routes/app_router.dart';

final GetIt getIt = GetIt.instance;

/// Service locator for all app's dependencies makes read and access to dependency easier
/// once it registered in the container here.
Future<void> registerDependencies(BuildConfig buildConfig) async {
  getIt.registerSingleton<BuildConfig>(buildConfig);
  getIt.registerSingleton<AppBlocObserver>(AppBlocObserver());
  getIt.registerSingleton<AppRouter>(AppRouter());
  getIt.registerFactoryParam<Dio, List<Interceptor>, dynamic>((interceptors, _) =>
      DioProvider.createInstance(baseUrl: buildConfig.apiBaseUrl, interceptors: interceptors,)
  );
  getIt.registerFactoryParam<ApiManager, Dio, dynamic>((dio, _) => DioApiManager(dio: dio),);
}