class AppException implements Exception {
  final _mess;
  final _prefix;

  AppException([this._mess, this._prefix]);

  @override
  String toString() {
    return "Message: $_mess \nPrefix: $_prefix";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? mess])
      : super(mess, "Error during Communication: ");
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, 'Invalid Request: ');
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message, 'Unauthorised Request: ');
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message, 'Invalid Input: ');
}
