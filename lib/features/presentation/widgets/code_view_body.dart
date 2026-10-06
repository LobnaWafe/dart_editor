import 'package:dart_compiler/features/presentation/view_model/code_editor_cubit/code_editor_cubit.dart';
import 'package:dart_compiler/features/presentation/views/output_view.dart';
import 'package:dart_compiler/features/presentation/widgets/dart_syntax_editing_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CodeViewBody extends StatefulWidget {
  const CodeViewBody({Key? key}) : super(key: key);

  @override
  State<CodeViewBody> createState() => _CodeViewBodyState();
}

class _CodeViewBodyState extends State<CodeViewBody> {
  late final DartSyntaxEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = DartSyntaxEditingController();
    _controller.text = 'void main() {\n print("hello world"); \n  }\n';
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    final cubit = context.read<CodeEditorCubit>();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 32),
        child: TextField(
          controller: _controller,
          maxLines: null,
          expands: true,
          enableInteractiveSelection: true,
          keyboardType: TextInputType.multiline,
          autofocus: true,
          onChanged: (text) {
            cubit.updateCode(text);
          },
          style: TextStyle(
            color: Colors.white,
            fontSize: width * 0.035,
            fontFamily: 'monospace',
            //  height: 1.5,
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: '// Write your Dart code here...',
            hintStyle: TextStyle(color: Colors.grey, fontFamily: 'monospace'),
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        height: width * 0.08,
        child: FloatingActionButton.extended(
          backgroundColor: Colors.blueAccent,

          icon: const Icon(Icons.play_arrow, color: Colors.white),
          label: Text(
            "Run Code",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: width * 0.03,
            ),
          ),
          onPressed: () {
            cubit.updateCode(_controller.text);
            cubit.runCodeMethod();
            if (width < 600) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: cubit,
                    child: const OutputView(),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
