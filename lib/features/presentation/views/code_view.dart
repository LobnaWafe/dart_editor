import 'package:dart_compiler/features/domain/repo/code_dart_eval_repo_imp.dart';
import 'package:dart_compiler/features/domain/repo/core_d4rt_repo_imp.dart';
import 'package:dart_compiler/features/presentation/view_model/code_editor_cubit/code_editor_cubit.dart';
import 'package:dart_compiler/features/presentation/widgets/code_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CodeView extends StatelessWidget {
  const CodeView({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.arrow_circle_down_sharp),
            onSelected: (value) {
              final cubit = context.read<CodeEditorCubit>();
              if (value == 'dart_eval') {
                cubit.changeCodeRepo(CodeDartEvalRepoImp());
              } else if (value == 'd4rt') {
                cubit.changeCodeRepo(CodeD4rtRepoImp());
              }
            },
            itemBuilder: (context) =>[
       const PopupMenuItem(
        value: "d4rt",
        child: Text("D4rt")
        ),

          const PopupMenuItem(
        value: "dart_eval",
        child: Text("Dart Eval")
        )
       ]),

          SizedBox(width: 20),
        ],
        title: Text(
          'Dart Code Editor',
          style: TextStyle(
            fontFamily: 'monospace',
            color: Colors.white,
            fontSize: width * 0.03,
          ),
        ),
      ),

      body: SafeArea(child: CodeViewBody()),
    );
  }
}
