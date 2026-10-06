import 'dart:async';

import 'package:dart_compiler/core/error/failure.dart';
import 'package:dart_compiler/features/domain/repo/code_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:d4rt/d4rt.dart';

class CodeD4rtRepoImp implements CodeRepo {
  @override
  Future<Either<Failure, String>> runCode({
    required String sourceCode,
  }) async {
    try {
      final List<String> output = [];

      final interpreter = D4rt();

      await runZoned(
        () {
          interpreter.execute(
            source: sourceCode,
          );
        },
        zoneSpecification: ZoneSpecification(
          print: (
            Zone self,
            ZoneDelegate parent,
            Zone zone,
            String line,
          ) {
            output.add(line);
          },
        ),
      );

      final result = output.join('\n');

      return Right(
        result.isEmpty
            ? 'Code executed successfully.'
            : result,
      );
    } catch (e) {
      return Left(
        ServerFailure(
          errorMsg: 'Execution Error:\n$e',
        ),
      );
    }
  }
}

