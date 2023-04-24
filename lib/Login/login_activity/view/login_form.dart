import 'package:flutter/material.dart';
import 'package:front_end/Custom%20Widgets/custom_widgets.dart';
import 'package:front_end/constants/colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
            padding: const EdgeInsets.all(26.0),
            child: Center(
                child: Stack(children: [
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
                  color: Palette.kToDark[900],
                ),
                child: Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Login",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w500),
                          )),
                      SizedBox(height: 50),
                      CustomTextField(
                        labelStyle: TextStyle(color: Colors.black),
                        //errorText: "Username is required",
                        labelText: "Username",
                      ),
                      SizedBox(height: 28),
                      CustomTextField(
                        labelText: "Password",
                        labelStyle: TextStyle(color: Colors.black),
                        obscureText: true,
                        //errorText: "Password is required",
                      )
                    ]),
              ),
            ]))));
  }
}