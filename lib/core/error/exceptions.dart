class ServerException implements Exception {
  final String message;
  final int? statusCode;
  ServerException({String? message, this.statusCode})
    : message =
          (message != null &&
              message.trim().isNotEmpty &&
              !message.toLowerCase().contains('serverexception') &&
              !message.toLowerCase().contains('instance of'))
          ? message.trim()
          : 'An unknown server error occurred.';

  @override
  String toString() => message;
}

class CacheException implements Exception {
  final String message;
  CacheException({this.message = 'An unknown cache error occurred.'});

  @override
  String toString() => message;
}

class NetworkException implements Exception {
  final String message;
  NetworkException({
    this.message = 'A network error occurred. Please check your connection.',
  });

  @override
  String toString() => message;
}
