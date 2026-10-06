import 'package:dart_compiler/features/presentation/views/code_view.dart';
import 'package:dart_compiler/features/presentation/views/output_view.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 600) {
          return Row(
            children: [
              Expanded(
                flex: 6,
                child: CodeView(),
              ),
              Expanded(
                flex: 4,
                child: OutputView(),
              ),
            ],
          );
        } else {
          return CodeView();
        }
      },
    );
  }
}