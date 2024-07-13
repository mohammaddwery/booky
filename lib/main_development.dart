import 'package:booky/bootstrap.dart';
import 'package:booky/core/utils/build_config.dart';
import 'app.dart';
import 'core/utils/app_constants.dart';

void main() {
  final config = DevelopmentBuildConfig(
      apiBaseUrl: 'https://openlibrary.org/',
      coverImageBaseUrl: 'https://covers.openlibrary.org/b/',
      environment: AppEnvironment.development,
  );
  bootstrap(
    appBuilder: () => const MyApp(),
    buildConfig: config,
  );
}


class DevelopmentBuildConfig extends BuildConfig {
DevelopmentBuildConfig({
    required String apiBaseUrl,
    required String coverImageBaseUrl,
    required AppEnvironment environment,
  }) : super(apiBaseUrl, coverImageBaseUrl, environment);
}
