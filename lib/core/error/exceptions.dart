class ServerException implements Exception {
  final String message;
  final int? statusCode;
  ServerException({this.message = 'An unknown server error occurred.', this.statusCode});

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
  NetworkException({this.message = 'A network error occurred. Please check your connection.'});

  @override
  String toString() => message;
}
