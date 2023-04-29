import 'package:flutter/material.dart';
import 'package:front_end/constants/fonts.dart';
import 'package:front_end/utils/screens/home_page.dart';
import 'package:front_end/utils/widgets/buttons.dart';
import 'package:front_end/utils/widgets/textfields.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _usernameController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(26.0),
        child: Center(
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                width: size.width,
                height: size.height * 0.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    width: 2,
                    color: Colors.grey,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Login",
                      style: Styles.titleLarge,
                    ),
                    const SizedBox(height: 50),
                    MainTextField(
                      label: "Username",
                      controller: _usernameController,
                    ),
                    const SizedBox(height: 28),
                    MainTextField(
                      label: "Password",
                      obsureText: true,
                      controller: _passwordController,
                    ),
                    const SizedBox(height: 42),
                    MainButton(
                      text: "Login",
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        );
                      },
                    )
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
