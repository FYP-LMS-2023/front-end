import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

var markdownFormattingGuide = "# Markdown Formatting Guide\n\n"
    "## Headers\n"
    "To create a header, add one to six # symbols before your heading text. The number of # you use will determine the size of the heading.\n\n"
    "Write this: \n"
    "```\n"
    "# The largest heading\n"
    "## The second largest heading\n"
    "###### The smallest heading\n"
    "```\n\n"
    "It will appear as: \n"
    "# The largest heading\n"
    "## The second largest heading\n"
    "###### The smallest heading\n\n"
    "---\n\n"
    "## Emphasis\n"
    "To emphasize text with bold, add two asterisks or underscores before and after a word or phrase. To emphasize text with italics, add one asterisk or underscore before and after a word or phrase.\n\n"
    "Write this: \n"
    "```\n"
    "**This is bold text**\n\n"
    "__This is bold text__\n\n"
    "*This text is italicized*\n\n"
    "_This text is italicized_\n\n"
    "```\n\n"
    "It will appear as: \n\n"
    "**This is bold text**\n\n"
    "__This is bold text__\n\n"
    "*This text is italicized*\n\n"
    "_This text is italicized_\n\n"
    "---\n\n"
    "## Lists\n"
    "You can organize items into ordered and unordered lists.\n\n"
    "### Unordered\n"
    "To create an unordered list, add dashes (-), asterisks (*), or plus signs (+) and a space before the text. Indent one or more items to create a nested list.\n\n"
    "Write this: \n"
    "```\n"
    "- George Washington\n"
    "- John Adams\n"
    "- Thomas Jefferson\n"
    "```\n\n"
    "It will appear as: \n"
    "- George Washington\n"
    "- John Adams\n"
    "- Thomas Jefferson\n\n"
    "### Ordered\n"
    "To create an ordered list, add numbers and a period before each line item. Indent one or more items to create a nested list.\n\n"
    "Write this: \n"
    "```\n"
    "1. James Madison\n"
    "2. James Monroe\n"
    "3. John Quincy Adams\n"
    "```\n\n"
    "It will appear as: \n"
    "1. James Madison\n"
    "2. James Monroe\n"
    "3. John Quincy Adams\n\n"
    "---\n\n"
    "## Code Blocks\n"
    "To create a code block, indent your text by four spaces or use triple backticks (`) before and after the code.\n\n"
    "Write this: \n"
    "```\n"
    "    print('Hello, World!');\n"
    "```\n\n"
    "It will appear as: \n"
    "```\n"
    "print('Hello, World!');\n"
    "```\n\n"
    "---\n\n"
    "## Blockquotes\n"
    "To create a blockquote, use the greater than (>) symbol before the text.\n\n"
    "Write this: \n"
    "```\n"
    "> This is a blockquote.\n"
    "```\n\n"
    "It will appear as: \n"
    "> This is a blockquote.\n\n";

Future<dynamic> markdown_helper(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    elevation: 2,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    builder: (BuildContext context) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.8,
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.48,
              child: Markdown(
                data: markdownFormattingGuide,
              ),
            ),
          ],
        ),
      );
    },
  );
}
