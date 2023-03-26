import 'package:flutter/material.dart';
import '../../constants/fonts.dart';

class MainButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final Color color;
  final bool enabled;

  const MainButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color = Colors.black,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return ElevatedButton(
      onPressed: enabled ? onPressed : null,
      style: ElevatedButton.styleFrom(
        minimumSize: Size.fromHeight(height * 0.06),
        backgroundColor: color,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        shadowColor: Colors.grey.shade900,
      ),
      child: Text(text, style: Styles.label_large),
    );
  }
}
