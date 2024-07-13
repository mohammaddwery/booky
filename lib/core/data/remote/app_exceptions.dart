
/// The handled exceptions might be thrown because of API request
/// includes API's response exception(server errors) or send/receive request errors(client error)
library;

class AppException implements Exception {
  final String message;
  AppException(this.message);
  @override
  String toString() {
    return "AppException: $message";
  }
}

class RequestCancelledException extends AppException {
  RequestCancelledException(super.message);
}

class InternetConnectionErrorException extends AppException {
  
  InternetConnectionErrorException(super.message);
}

class UnexpectedErrorException extends AppException {
  
  UnexpectedErrorException(super.message);
}

class UnableToProcessException extends AppException {
  
  UnableToProcessException(super.message);
}

class RequestTimeoutException extends AppException {
  
  RequestTimeoutException(super.message);
}

class ReceiveTimeoutException extends AppException {
  
  ReceiveTimeoutException(super.message);
}

class SendTimeoutException extends AppException {
  
  SendTimeoutException(super.message);
}

class BadRequestException extends AppException {
  
  BadRequestException(super.message);
}

class UnauthorizedRequestException extends AppException {
  
  UnauthorizedRequestException(super.message);
}

class ForbiddenException extends AppException {
  
  ForbiddenException(super.message);
}

class NotFoundException extends AppException {
  
  NotFoundException(super.message);
}

class UnProcessableEntityException extends AppException {
  
  UnProcessableEntityException(super.message);
}