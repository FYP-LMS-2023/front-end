import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:front_end/constants/colors.dart';

class FormattedTextWidget extends StatelessWidget {
  final String markdownText;

  const FormattedTextWidget({required this.markdownText});

  @override
  Widget build(BuildContext context) {
    return Markdown(
      data: markdownText,
      shrinkWrap: true,
      //need to make the code block background color dark and text color white
      styleSheet: MarkdownStyleSheet(
        code: TextStyle(
          backgroundColor: Palette.kToDark,
          color: Colors.white,
        ),
        codeblockDecoration: BoxDecoration(
          color: Palette.kToDark[50],
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}
