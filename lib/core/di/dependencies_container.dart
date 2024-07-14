import 'package:booky/core/data/remote/api_manager.dart';
import 'package:booky/core/data/remote/dio_api_manger.dart';
import 'package:booky/core/utils/build_config.dart';
import 'package:booky/data/resources/remote/books_api_provider.dart';
import 'package:booky/repository/books_repository.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../app_bloc_observer.dart';
import '../../data/repository/app_books_repository.dart';
import '../../data/resources/local/books_store_provider.dart';
import '../../presentation/routes/app_router.dart';
import '../data/local/store_manager.dart';

final GetIt getIt = GetIt.instance;

/// Service locator for all app's dependencies makes read and access to dependency easier
/// once it registered in the container here.
Future<void> registerDependencies(BuildConfig buildConfig) async {
  /// App's infrastructure dependencies

  final SharedPreferences preferences = await SharedPreferences.getInstance();

  getIt.registerSingleton<BuildConfig>(buildConfig);
  getIt.registerSingleton<AppBlocObserver>(AppBlocObserver());
  getIt.registerSingleton<StoreManager>(SharedPreferencesManager(preferences));
  getIt.registerSingleton<AppRouter>(AppRouter());
  getIt.registerFactoryParam<Dio, List<Interceptor>?, dynamic>((interceptors, _) =>
      DioProvider.createInstance(baseUrl: buildConfig.apiBaseUrl, interceptors: interceptors,)
  );
  getIt.registerFactoryParam<ApiManager, Dio, dynamic>((dio, _) => DioApiManager(dio: dio),);


  /// App's Features dependencies
  getIt.registerFactory<BooksApiProvider>(() => AppBooksApiProvider(
      getIt.get<ApiManager>(param1: getIt.get<Dio>(),),
  ));
  getIt.registerFactory<BooksStoreProvider>(() => AppBooksStoreProvider(
      getIt.get<StoreManager>(),
  ));
  getIt.registerFactory<BooksRepository>(() => AppBooksRepository(
      getIt.get<BooksApiProvider>(),
      getIt.get<BooksStoreProvider>(),
  ));
}