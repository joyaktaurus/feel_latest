// @dart=2.9
class NetworkException implements Exception {
  String message;
  int code;
  String error;

  NetworkException({this.message, this.code, this.error});

  @override
  String toString() {
    return "$code-$message";
  }
}

class AuthException extends NetworkException {
  AuthException({message, code}) : super(message: message, code: code);
}
