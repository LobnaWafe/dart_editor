import 'package:dart_compiler/core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class CodeRepo {
  Future<Either<Failure, String>> runCode({required String sourceCode});
}

