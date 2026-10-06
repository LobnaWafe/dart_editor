
import 'package:dart_compiler/features/domain/repo/code_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'code_editor_state.dart';

class CodeEditorCubit extends Cubit<CodeEditorState> {
  CodeRepo codeRepo;

  CodeEditorCubit({
    required this.codeRepo,
  }) : super(CodeEditorInitialState());

  String _currentCode = '';

  void updateCode(String code) {
    _currentCode = code;
  }

  String get currentCode => _currentCode;

  void changeCodeRepo(CodeRepo newRepo) {
    codeRepo = newRepo;
  }

  Future<void> runCodeMethod() async {
    if (_currentCode.trim().isEmpty) {
      emit(
        CodeEditorErrorState(
          'Code is empty. Please enter Dart code.',
        ),
      );
      return;
    }

    emit(CodeEditorLoadingState());

    final result = await codeRepo.runCode(
      sourceCode: _currentCode,
    );

    result.fold(
      (failure) {
        emit(
          CodeEditorErrorState(
            failure.errorMsg,
          ),
        );
      },
      (result) {
        emit(
          CodeEditorSuccessState(result),
        );
      },
    );
  }
}




// import 'package:dart_compiler/features/domain/repo/code_repo.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'code_editor_state.dart';

// class CodeEditorCubit extends Cubit<CodeEditorState> {
//   final CodeRepo codeRepo;

//   CodeEditorCubit({
//     required this.codeRepo,
//   }) : super(CodeEditorInitialState());

//   String _currentCode = '';

//   void updateCode(String code) {
//     _currentCode = code;
//   }

//   String get currentCode => _currentCode;

//   Future<void> runCodeMethod() async {
//     if (_currentCode.trim().isEmpty) {
//       emit(
//         CodeEditorErrorState(
//           'Code is empty. Please enter Dart code.',
//         ),
//       );
//       return;
//     }

//     emit(CodeEditorLoadingState());

//     final result = await codeRepo.runCode(
//       sourceCode: _currentCode,
//     );

//     result.fold(
//       (failure) {
//         emit(
//           CodeEditorErrorState(
//             failure.errorMsg,
//           ),
//         );
//       },
//       (result) {
//         emit(
//           CodeEditorSuccessState(
//             result,
//           ),
//         );
//       },
//     );
//   }
// }
