class HttpException implements Exception {
  final errorMessage;

  HttpException(this.errorMessage);

  @override
  String toString() => errorMessage;
}
