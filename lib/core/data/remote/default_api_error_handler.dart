import 'dart:io';
import 'package:booky/core/data/remote/api_manager.dart';
import 'package:dio/dio.dart';

import '../../utils/app_logger.dart';
import 'app_exceptions.dart';

/// Base error handler that [ApiManager] depends on.
/// Please extends from [ApiErrorHandler] once you need a new/custom error handler
/// Hint: create new error handler when you need to handle errors in different ways on environment switching.
abstract class ApiErrorHandler {
  const ApiErrorHandler();
  Exception onError(error);
}

/// Default API error handler that [ApiManager] depends on.
class DefaultApiErrorHandler extends ApiErrorHandler {
  const DefaultApiErrorHandler();

  @override
  Exception onError(error) {
    if (error is Exception) {
      try {
        if (error is DioException) {
          logger.e('DefaultApiErrorHandler', error: error.toString(), stackTrace: error.stackTrace);
          return _handleDioError(error);
        }

        if (error is SocketException) {
          logger.e('DefaultApiErrorHandler', error: error.toString(),);
          return InternetConnectionErrorException('sorry_internet_connection_error');
        }

        return UnexpectedErrorException('sorry_something_went_wrong');
      } catch (_) {
        logger.e('DefaultApiErrorHandler', error: error.toString(),);
        return UnexpectedErrorException('sorry_something_went_wrong');
      }
    }

    if (error.toString().contains("is not a subtype of")) {
      logger.e('DefaultApiErrorHandler', error: error.toString(),);
      return UnableToProcessException('unable_to_process_data');
    }

    logger.e('DefaultApiErrorHandler', error: error.toString(),);
    return UnexpectedErrorException('sorry_something_went_wrong');
  }

  Exception _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.cancel:
        return RequestCancelledException('request_canceled');
      case DioExceptionType.connectionTimeout:
        return RequestTimeoutException('request_timeout');
      case DioExceptionType.connectionError:
      case DioExceptionType.unknown:
      case DioExceptionType.badCertificate:
        return InternetConnectionErrorException('sorry_internet_connection_error');
      case DioExceptionType.receiveTimeout:
        return ReceiveTimeoutException('receive_timeout');
      case DioExceptionType.sendTimeout:
        return SendTimeoutException('send_timeout');

      case DioExceptionType.badResponse:
        return _getDioResponseException(error);
    }
  }

  static Exception _getDioResponseException(DioException error) {
    switch (error.response?.statusCode) {
      case 400:
        String message = error.response?.statusMessage??'bad_request';
        return BadRequestException(message);

      case 401:
        /// Here could perform logout
        String message = error.response?.statusMessage??'unauthorized';
        return UnauthorizedRequestException(message);

      case 403:
        String message = error.response?.statusMessage??'forbidden';
        return ForbiddenException(message);

      case 404:
        String message = error.response?.statusMessage??'not_found';
        return NotFoundException(message);
        
      case 422:
        String message = error.response?.statusMessage??'un_processable_entity';
        return UnProcessableEntityException(message);
        
      default:
        return UnexpectedErrorException('sorry_something_went_wrong');
    }
  }
}