import 'dart:async';

import 'package:dart_compiler/core/error/failure.dart';
import 'package:dart_compiler/features/domain/repo/code_repo.dart';
import 'package:dart_eval/dart_eval.dart';
import 'package:dartz/dartz.dart';

class CodeDartEvalRepoImp implements CodeRepo{
 Future<Either<Failure, String>> runCode({
    required String sourceCode,
  }) async {
    try {
      final List<String> output = [];

      // Compile the user's code.
      final compiler = Compiler();

      final program = compiler.compile({
        'user_code': {
          'main.dart': sourceCode,
        },
      });

      // Create the runtime.
      final runtime = Runtime.ofProgram(program);

      // Run the user's code inside a Zone
      // so we can capture print() output.
      await runZoned(
        () {
          runtime.executeLib(
            'package:user_code/main.dart',
            'main',
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

      final String result = output.join('\n');

      return Right(
        result.isEmpty
            ? 'Code executed successfully.'
            : result,
      );
    } catch (e) {
      return Left(
        ServerFailure(
          errorMsg: 'Compilation Error:\n$e',
        ),
      );
    }
  }
}
