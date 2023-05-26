import 'package:flutter/material.dart';
import 'package:front_end/constants/colors.dart';
import 'package:front_end/constants/fonts.dart';
import 'package:front_end/constants/spacers.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.width * 0.35),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                "assets/images/icon.png",
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              CircularProgressIndicator(
                color: lightButtonColor,
                strokeWidth: 4,
              ),
              Row(
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
                      color: lightGreen,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
