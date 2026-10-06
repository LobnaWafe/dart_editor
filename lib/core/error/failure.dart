abstract class Failure {
  final String errorMsg;

  Failure({required this.errorMsg});
}

class ServerFailure extends Failure{
  ServerFailure({required super.errorMsg});
}