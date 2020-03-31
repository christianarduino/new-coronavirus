class NoInternetException {
  NoInternetException(this.message);
  final String message;
}

class NoServiceFoundException {
  NoServiceFoundException(this.message);
  final String message;
}

class InvalidFormatException {
  InvalidFormatException(this.message);
  final String message;
}

class UnknownException {
  UnknownException(this.message);
  final String message;
}

class ServerTimeoutException {
  ServerTimeoutException(this.message);
  final String message;
}

String showError(Object error) {
  print(error);
  if (error is NoInternetException) {
    NoInternetException noInternetException = error;
    return noInternetException.message;
  }

  if (error is NoServiceFoundException) {
    NoServiceFoundException noServiceFoundException = error;
    return noServiceFoundException.message;
  }

  if (error is InvalidFormatException) {
    InvalidFormatException invalidFormatException = error;
    return invalidFormatException.message;
  }

  if (error is UnknownException) {
    UnknownException unknownException = error;
    return unknownException.message;
  }

  if (error is ServerTimeoutException) {
    ServerTimeoutException serverTimeoutException = error;
    return serverTimeoutException.message;
  }

  print(error);
  return "Si è verificato un errore, riprova";
}
