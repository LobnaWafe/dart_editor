import 'package:dart_compiler/features/domain/repo/code_dart_eval_repo_imp.dart';
import 'package:dart_compiler/features/domain/repo/core_d4rt_repo_imp.dart';
import 'package:dart_compiler/features/presentation/view_model/code_editor_cubit/code_editor_cubit.dart';
import 'package:dart_compiler/features/presentation/views/home_view.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(DevicePreview(enabled: false, builder: (context) => const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CodeEditorCubit(codeRepo: CodeD4rtRepoImp()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        themeMode: ThemeMode.dark,
        darkTheme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: const Color(0xFF1E1E1E),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF252526),
            elevation: 0,
          ),
          colorScheme: const ColorScheme.dark(
            primary: Colors.blueAccent,
            surface: Color(0xFF252526),
          ),
        ),
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: const Color(0xFF1E1E1E),
        ),
        home: const HomeView(),
      ),
    );
  }
}
