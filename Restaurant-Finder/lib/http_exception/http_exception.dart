
class HttpException with Exception {
  String _message;

  HttpException(this._message);

  @override
  String toString() => _message;
}