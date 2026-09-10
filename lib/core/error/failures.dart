import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);

  @override
  List<Object> get props => [message];

  @override
  String toString() => message;
}

// General failures
class ServerFailure extends Failure {
  ServerFailure(String message)
    : super(
        (message.toLowerCase().contains('serverexception') ||
                message.toLowerCase().contains('instance of'))
            ? 'An unknown server error occurred.'
            : message,
      );

  const ServerFailure.raw(super.message);
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

class UnknownFailure extends Failure {
  const UnknownFailure(super.message);
}
