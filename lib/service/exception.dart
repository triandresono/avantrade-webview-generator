class GeneralException implements Exception {
  final String message;
  GeneralException(this.message);
}

class MobileException extends GeneralException {
  MobileException(
    super.message,
  );
}

class APIException implements Exception {
  final String prefix;
  final String message;
  final int? statusCode;
  final String? errorCode;

  APIException(this.prefix, this.message, this.statusCode, this.errorCode);
}

class FetchDataException extends APIException {
  FetchDataException({
    required String message,
    required int? statusCode,
    String? errorCode,
  }) : super(
          "Error During Communication: ",
          message,
          statusCode,
          errorCode,
        );
}

class BadRequestException extends APIException {
  BadRequestException({
    required String message,
    required int? statusCode,
    String? errorCode,
  }) : super(
          "Invalid Request: ",
          message,
          statusCode,
          errorCode,
        );
}

class UnauthorisedException extends APIException {
  UnauthorisedException({
    required String message,
    required int? statusCode,
    String? errorCode,
  }) : super(
          "Unauthorised: ",
          message,
          statusCode,
          errorCode,
        );
}

class ForbiddenAccessException extends APIException {
  ForbiddenAccessException({
    required String message,
    required int? statusCode,
    String? errorCode,
  }) : super(
          "Forbidden Access: ",
          message,
          statusCode,
          errorCode,
        );
}

class NotFoundException extends APIException {
  NotFoundException({
    required String message,
    required int? statusCode,
    String? errorCode,
  }) : super(
          "Not Found: ",
          message,
          statusCode,
          errorCode,
        );
}

class InvalidInputException extends APIException {
  InvalidInputException({
    required String message,
    required int? statusCode,
    String? errorCode,
  }) : super(
          "Invalid Input: ",
          message,
          statusCode,
          errorCode,
        );
}

class ErrorResponse {
  static dynamic customError({
    required String message,
    int? statusCode = 500,
    String? errorCode,
    String? errors,
  }) {
    throw FetchDataException(
      message: message,
      statusCode: statusCode ?? 500,
      errorCode: errorCode,
    );
  }

  static dynamic mapErrorResponse({
    required String message,
    int? statusCode = 500,
    String? errorCode,
    String? errors,
  }) {
    // RGLogger.e(
    //   "$statusCode: $message",
    //   stacktrace: StackTrace.current,
    //   ex: Exception([message]),
    // );

    switch (statusCode) {
      case 400:
        throw BadRequestException(
          message: message,
          statusCode: 400,
          errorCode: errorCode,
        );
      case 403:
        throw ForbiddenAccessException(
          message: message,
          statusCode: 403,
          errorCode: errorCode,
        );
      case 401:
        throw UnauthorisedException(
          message: message,
          statusCode: 401,
          errorCode: errorCode,
        );
      case 404:
        throw NotFoundException(
          message: message,
          statusCode: 404,
          errorCode: errorCode,
        );
      case 600:
        throw FetchDataException(
          message: 'No Connection',
          statusCode: 600,
          errorCode: errorCode,
        );
      case 408:
        throw FetchDataException(
          message: 'Request Timeout',
          statusCode: 408,
          errorCode: errorCode,
        );
      case null:
        throw FetchDataException(
          message: 'Server down.',
          statusCode: statusCode,
          errorCode: errorCode,
        );
      case 500:
      default:
        throw FetchDataException(
          message: errors!.isEmpty
              ? 'Error Communication Server with StatusCode : $statusCode'
              : errors,
          statusCode: 500,
          errorCode: errorCode,
        );
    }
  }
}
