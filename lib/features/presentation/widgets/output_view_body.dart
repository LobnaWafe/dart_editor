import 'package:dart_compiler/features/presentation/view_model/code_editor_cubit/code_editor_cubit.dart';
import 'package:dart_compiler/features/presentation/view_model/code_editor_cubit/code_editor_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OutputViewBody extends StatelessWidget {
  const OutputViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BlocBuilder<CodeEditorCubit, CodeEditorState>(
        builder: (context, state) {
          if (state is CodeEditorLoadingState) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.blueAccent),
            );
          } else if (state is CodeEditorSuccessState) {
            return Container(
              width: double.infinity,
              height: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: const Color(0xFF0E0E0E),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.green.withOpacity(0.5)),
              ),
              child: SingleChildScrollView(
                child: SelectableText(
                  // استبدال Text بـ SelectableText للنسخ
                  state.output,
                  style:  TextStyle(
                    color: Colors.lightGreenAccent,
                     fontSize: width*0.035,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            );
          } else if (state is CodeEditorErrorState) {
            return Container(
              width: double.infinity,
              height: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: const Color(0xFF0E0E0E),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.red.withOpacity(0.5)),
              ),
              child: SingleChildScrollView(
                child: SelectableText(
                  // استبدال Text بـ SelectableText للنسخ
                  state.error,
                  style:  TextStyle(
                    color: Colors.redAccent,
                      fontSize: width*0.035,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            );
          }

          return  Center(
            child: Text(
              'No execution output available.',
              style: TextStyle(color: Colors.grey, fontFamily: 'monospace',
              fontSize: width*0.035,
              ),
            ),
          );
        },
      ),
    );
  }
}
