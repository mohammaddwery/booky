
/// The handled exceptions might be thrown because of API request
/// includes API's response exception(server errors) or send/receive request errors(client error)
library;


class RequestCancelledException implements Exception {
  final String message;
  RequestCancelledException(this.message);
}

class InternetConnectionErrorException implements Exception {
  final String message;
  InternetConnectionErrorException(this.message);
}

class UnexpectedErrorException implements Exception {
  final String message;
  UnexpectedErrorException(this.message);
}

class UnableToProcessException implements Exception {
  final String message;
  UnableToProcessException(this.message);
}

class RequestTimeoutException implements Exception {
  final String message;
  RequestTimeoutException(this.message);
}

class ReceiveTimeoutException implements Exception {
  final String message;
  ReceiveTimeoutException(this.message);
}

class SendTimeoutException implements Exception {
  final String message;
  SendTimeoutException(this.message);
}

class BadRequestException implements Exception {
  final String message;
  BadRequestException(this.message);
}

class UnauthorizedRequestException implements Exception {
  final String message;
  UnauthorizedRequestException(this.message);
}

class ForbiddenException implements Exception {
  final String message;
  ForbiddenException(this.message);
}

class NotFoundException implements Exception {
  final String message;
  NotFoundException(this.message);
}

class UnProcessableEntityException implements Exception {
  final String message;
  UnProcessableEntityException(this.message);
}