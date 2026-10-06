import 'package:dart_compiler/features/presentation/widgets/output_view_body.dart';
import 'package:flutter/material.dart';

class OutputView extends StatelessWidget {
  final bool isFullScreen;

  const OutputView({
    super.key,
    this.isFullScreen = false,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    final isTablet = width >= 600;

    return Scaffold(
      appBar: AppBar(
        leading: isTablet
            ? IconButton(
                icon: Icon(
                  isFullScreen
                      ? Icons.close_fullscreen
                      : Icons.open_in_full,
                  size: width * 0.03,
                ),
                onPressed: () {
                  if (isFullScreen) {
                    Navigator.pop(context);
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OutputView(
                          isFullScreen: true,
                        ),
                      ),
                    );
                  }
                },
              )
            : null,
        title: Text(
          'Execution Console',
          style: TextStyle(
            fontFamily: 'monospace',
            color: Colors.white,
            fontSize: width * 0.035,
          ),
        ),
        backgroundColor: const Color(0xFF252526),
        elevation: 0,
      ),
      body: const SafeArea(
        child: OutputViewBody(),
      ),
    );
  }
}