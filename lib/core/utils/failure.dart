class Failure implements Exception {
  final String message;
  Failure(this.message);
}

class CustomFormatExcaption extends Failure {
  CustomFormatExcaption(String message) : super(message);
}

class CustomTimeoutException extends Failure {
  CustomTimeoutException(String message) : super(message);
}

class CustomConnectionException extends Failure {
  CustomConnectionException(String message) : super(message);
}

class CustomServerException extends Failure {
  CustomServerException(String message) : super(message);
}

class CustomUnauthorizedException extends Failure {
  CustomUnauthorizedException(String message) : super(message);
}

class UnknownException extends Failure {
  UnknownException(String message) : super(message);
}
