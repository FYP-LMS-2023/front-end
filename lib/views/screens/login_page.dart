import 'package:flutter/material.dart';
import 'package:front_end/constants/box_decoration.dart';
import 'package:front_end/constants/fonts.dart';
import 'package:front_end/constants/spacers.dart';
import '../../views/widgets/textfields.dart';
import '../../views/widgets/buttons.dart';
import '../../views/screens/homepage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "SMASH LMS",
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
              const VerticalSpacer(),
              Container(
                padding: const EdgeInsets.all(16),
//                width: size.width,
                decoration: boxDecoration,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Login",
                      style: Styles.titleLarge,
                    ),
                    // const SizedBox(height: 50),
                    const VerticalSpacer(),
                    MainTextField(
                      label: "Username",
                      controller: usernameController,
                    ),
                    // const SizedBox(height: 28),
                    const VerticalSpacer(),
                    MainTextField(
                      label: "Password",
                      obsureText: true,
                      controller: passwordController,
                    ),
                    const VerticalSpacer(),
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
                    const VerticalSpacer(),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
