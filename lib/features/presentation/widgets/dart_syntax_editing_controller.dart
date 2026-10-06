import 'package:flutter/material.dart';

class DartSyntaxEditingController extends TextEditingController {
  // Dart keywords
  static const List<String> keywordsYellow = [
    'class',
    'abstract',
    'extends',
    'implements',
    'with',
    'mixin',
    'enum',
    'typedef',
    'import',
    'export',
    'library',
    'part',
  ];

  // Variables, data types and built-in functions
  static const List<String> keywordsBlue = [
    'var',
    'final',
    'const',
    'late',
    'dynamic',
    'void',
    'int',
    'String',
    'print',
    'double',
    'num',
    'bool',
    'List',
    'Map',
    'Set',
    'Future',
    'Stream',
  ];

  // Control flow keywords
  static const List<String> keywordsGreen = [
    'if',
    'else',
    'for',
    'while',
    'do',
    'switch',
    'case',
    'default',
    'return',
    'break',
    'continue',
    'yield',
    'async',
    'await',
    'try',
    'catch',
    'finally',
    'throw',
  ];

  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    required bool withComposing,
  }) {
    final List<TextSpan> children = [];
    final String fullText = text;

    if (fullText.isEmpty) {
      return TextSpan(style: style);
    }

    final RegExp regExp = RegExp(
      r'"[^"]*"|[a-zA-Z_]\w*|[(){}\[\]]|[^\s\w]',
    );

    int lastMatchEnd = 0;

    for (final Match match in regExp.allMatches(fullText)) {
      // Add normal text before the current token.
      if (match.start > lastMatchEnd) {
        children.add(
          TextSpan(
            text: fullText.substring(lastMatchEnd, match.start),
            style: style,
          ),
        );
      }

      final String token = match.group(0)!;

      // 1. Strings
      if (token.startsWith('"') && token.endsWith('"')) {
        children.add(
          TextSpan(
            text: token,
            style: style?.copyWith(
              color: Colors.orangeAccent,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      }

      // 2. Parentheses / Brackets / Braces
      else if (RegExp(r'^[(){}\[\]]$').hasMatch(token)) {
        children.add(
          TextSpan(
            text: token,
            style: style?.copyWith(
              color: Colors.cyanAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }

      // 3. Yellow keywords
      else if (keywordsYellow.contains(token)) {
        children.add(
          TextSpan(
            text: token,
            style: style?.copyWith(
              color: Colors.yellowAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }

      // 4. Blue keywords / types
      else if (keywordsBlue.contains(token)) {
        children.add(
          TextSpan(
            text: token,
            style: style?.copyWith(
              color: Colors.lightBlueAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }

      // 5. Green control-flow keywords
      else if (keywordsGreen.contains(token)) {
        children.add(
          TextSpan(
            text: token,
            style: style?.copyWith(
              color: Colors.greenAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }

      // 6. Normal text
      else {
        children.add(
          TextSpan(
            text: token,
            style: style,
          ),
        );
      }

      lastMatchEnd = match.end;
    }

    // Add remaining text after the last token.
    if (lastMatchEnd < fullText.length) {
      children.add(
        TextSpan(
          text: fullText.substring(lastMatchEnd),
          style: style,
        ),
      );
    }

    return TextSpan(
      style: style,
      children: children,
    );
  }
}