import 'app_constants.dart';

abstract class BuildConfig {
  final String apiBaseUrl;
  final String coverImageBaseUrl;
  final AppEnvironment environment;
  BuildConfig(this.apiBaseUrl, this.coverImageBaseUrl, this.environment);
}
