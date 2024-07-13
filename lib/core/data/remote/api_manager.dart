import 'default_api_error_handler.dart';

abstract class ApiManager {
  final ApiErrorHandler apiErrorHandler;
  ApiManager({this.apiErrorHandler = const DefaultApiErrorHandler()});

  void close({bool force=false});
  Future<dynamic> get({
    Map<String, String?> headers = const {},
    Map<String, dynamic>? queryParameters,
    required String url,
  });
  Future<dynamic> post({
    Map<String, String?> headers = const {},
    Map<String, dynamic>? queryParameters,
    required String url,
    Object? body,
  });
}