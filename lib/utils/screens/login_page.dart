import 'package:flutter/material.dart';
import 'package:front_end/utils/screens/course_overview_page.dart';
import 'package:front_end/utils/screens/home_page.dart';
import 'package:front_end/utils/widgets/buttons.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text("Login Page"),
            MainButton(
              text: "Login",
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
