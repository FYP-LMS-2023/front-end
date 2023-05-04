import 'package:flutter/material.dart';

class HorizontalSpacer extends StatelessWidget {
  const HorizontalSpacer({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(width: size.width * 0.05);
  }
}

class VerticalSpacer extends StatelessWidget {
  const VerticalSpacer({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(height: size.height * 0.04);
  }
}
