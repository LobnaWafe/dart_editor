abstract class CodeEditorState {}

class CodeEditorInitialState extends CodeEditorState {}

class CodeEditorLoadingState extends CodeEditorState {}

class CodeEditorSuccessState extends CodeEditorState {
  final String output;
  CodeEditorSuccessState(this.output);
}

class CodeEditorErrorState extends CodeEditorState {
  final String error;
  CodeEditorErrorState(this.error);
}