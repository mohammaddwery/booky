import 'dart:developer';

import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'api_manager.dart';
import 'package:dio/dio.dart';

/// Helper class that creates an instance of [Dio] with specific arguments
/// Use this class when your app needs multiple dio instances with different options(interceptors, ...)
abstract class DioProvider {
  static Dio createInstance({
    required String baseUrl,
    List<Interceptor>? interceptors,
  }) => Dio(BaseOptions(
    baseUrl: baseUrl,
    receiveDataWhenStatusError: true,
  ))
    ..interceptors.addAll([
      ...interceptors=const[],
      // PrettyDioLogger( // TODO: Uncomment this when you need logger
      //   requestHeader: true,
      //   requestBody: true,
      //   responseBody: true,
      //   responseHeader: false,
      //   compact: false,
      //   logPrint: (object) => log(object.toString()),
      // ),
    ]);
}

/// Dio wrapper aims to:
/// encapsulates Dio functionalities and exposes the needed functionalities
/// Insure loose coupling and applies dependency inversion principle
class DioApiManager extends ApiManager {
  final Dio _dio;
  DioApiManager({
    required Dio dio,
    super.apiErrorHandler,
  }): _dio = dio;

  Future<dynamic> _handleApiRequest(Future<Response<dynamic>> request) async {
    try {
      final response = await request;
      if(response.data == null) throw apiErrorHandler.onError('');

      return response.data!;
    } catch (e) {
      throw apiErrorHandler.onError(e);
    }
  }

  @override
  close({bool force= false}) {
    _dio.close(force: force);
  }

  @override
  Future<dynamic> get({
    required String url,
    Map<String, String?> headers = const {},
    Map<String, dynamic>? queryParameters,
  }) => _handleApiRequest(
    _dio.get(
      url,
      queryParameters: queryParameters,
      options: Options(headers: headers,),
    ),
  );

  @override
  Future post({
    Map<String, String?> headers = const {},
    required String url,
    Map<String, dynamic>? queryParameters,
    Object? body,
  }) => _handleApiRequest(_dio.post(
      url,
      data: body,
      options: Options(headers: headers,),
      queryParameters: queryParameters,
    ),);
}