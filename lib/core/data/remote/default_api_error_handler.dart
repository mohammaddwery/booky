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
    logger.e('CoreNetworkExceptions', error: error.toString(),);

    if (error is Exception) {
      try {
        if (error is DioException) {
          return _handleDioError(error);
        }

        if (error is SocketException) {
          return InternetConnectionErrorException('sorry_internet_connection_error');
        }

        return UnexpectedErrorException('sorry_something_went_wrong');
      } catch (_) {
        return UnexpectedErrorException('sorry_something_went_wrong');
      }
    }

    if (error.toString().contains("is not a subtype of")) {
      return UnableToProcessException('unable_to_process_data');
    }
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
    switch (error.response!.statusCode) {
      case 400:
        String message = '';
        if(error.response!.data['message'] is List) {
          List<String> messages = List<String>.from(error.response!.data['message'].map((x) => x.toString()));
          message =  messages.join('\n');
        } else {
          message = error.response!.data['message'];
        }
        return BadRequestException(message);

      case 401:
        /// Here could perform logout 
        String message = error.response!.data['message'];
        return UnauthorizedRequestException(message);

      case 403:
        String message = error.response!.data['message'];
        return ForbiddenException(message);

      case 404:
        String message = error.response!.data['message'];
        return NotFoundException(message);
        
      case 422:
        String message = error.response!.data['message'];
        return UnProcessableEntityException(message);
        
      default:
        return UnexpectedErrorException('sorry_something_went_wrong');
    }
  }
}