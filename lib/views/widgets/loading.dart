import 'package:flutter/material.dart';
import 'package:front_end/constants/fonts.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        const Align(
          alignment: Alignment.center,
          child: CircularProgressIndicator(
            color: Colors.black,
            strokeWidth: 3,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          heightFactor: MediaQuery.of(context).size.height * 0.05,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "made by ",
                style: Styles.bodySmall.copyWith(
                  color: Colors.grey,
                ),
              ),
              Text(
                " LapaS. Corp ",
                style: Styles.bodySmall.copyWith(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
