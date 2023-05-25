import 'package:flutter/material.dart';
import 'package:front_end/constants/fonts.dart';

class Subheading extends StatelessWidget {
  const Subheading({super.key, required this.text});

  final String text;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            text,
            style: Styles.labelLarge,
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.015,
        ),
      ],
    );
  }
}
