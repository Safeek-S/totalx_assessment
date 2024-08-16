class Result<T> {
  final StatusCode statusCode;
  final String message;
  final T data;

  Result(
    this.statusCode,
    this.message,
    this.data,
  );
}

enum StatusCode {
  success,
  failure,
  unExpectedError;
}
