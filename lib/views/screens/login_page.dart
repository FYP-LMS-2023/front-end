import 'package:flutter/material.dart';
import 'package:front_end/constants/box_decoration.dart';
import 'package:front_end/constants/fonts.dart';
import 'package:front_end/constants/spacers.dart';
import 'package:front_end/controllers/user_controller.dart';
import 'package:front_end/views/screens/dummy_faculty_screen.dart';
import 'package:front_end/views/screens/faculty/faculty_home.dart';
import 'package:front_end/views/widgets/loading.dart';
import 'package:provider/provider.dart';
import '../../constants/log.dart';
import '../../views/widgets/textfields.dart';
import '../../views/widgets/buttons.dart';
import '../../views/screens/homepage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool loading = false;
  bool blockedError = false;
  bool validationError = false;
  final _formKey = GlobalKey<FormState>();

  userLogin() async {
    setState(() {
      loading = true;
    });
    Log.i("Login button pressed");
    Log.i("password contoroller ${passwordController.text}");
    Log.i("usernameController ${usernameController.text}");
    Log.i("Login button pressed");

    await context
        .read<UserController>()
        .login(
          usernameController.text,
          passwordController.text,
          // "stud1@gmail.com",
          // "fac1@gmail.com",
          // "123456"
        )
        .then(
      (value) {
        if (value == true) {
          setState(() {
            loading = false;
          });
          var userType = context.read<UserController>().getUser?.userType;
          if (userType == "Student") {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          } else if (userType == "Faculty") {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const FacHome(),
              ),
            );
          }
        } else {
          var errorCode = context.read<UserController>().getErrorCode;
          setState(() {
            loading = false;
          });

          if (errorCode == 403) {
            setState(() {
              blockedError = true;
            });
          }

          if (errorCode == 401) {
            setState(() {
              validationError = true;
            });
          }
          ;
        }
      },
    );
  }

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: loading
          ? const Loading()
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Padding(
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.width * 0.09),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "SMASH LMS",
                            style: TextStyle(
                                fontSize: 36, fontWeight: FontWeight.bold),
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
                                if (blockedError)
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: size.height * 0.01,
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        width: double.infinity,
                                        height: size.height * 0.04,
                                        color: Colors.redAccent,
                                        child: Padding(
                                          padding: EdgeInsets.all(
                                              size.width * 0.016),
                                          child: Text(
                                            "Account has been deactivated",
                                            style: Styles.bodySmall
                                                .copyWith(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                if (validationError)
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: size.height * 0.01,
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        width: double.infinity,
                                        height: size.height * 0.04,
                                        color: Colors.redAccent,
                                        child: Padding(
                                          padding: EdgeInsets.all(
                                              size.width * 0.016),
                                          child: Text(
                                            "Invalid username or password",
                                            style: Styles.bodySmall
                                                .copyWith(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                const VerticalSpacer(),
                                MainTextField(
                                    label: "Username",
                                    controller: usernameController,
                                    validator: (value) {
                                      if (value?.isEmpty ?? true) {
                                        return "Please enter username";
                                      }
                                      return null;
                                    }),
                                const VerticalSpacer(),
                                MainTextField(
                                  label: "Password",
                                  obsureText: true,
                                  controller: passwordController,
                                  validator: (value) {
                                    if (value?.isEmpty ?? true) {
                                      return "Please enter password";
                                    }
                                    return null;
                                  },
                                ),
                                const VerticalSpacer(),
                                MainButton(
                                  text: "Login",
                                  onPressed: () async {
                                    Log.i("Login button pressed");

                                    // await userLogin();
                                    if (_formKey.currentState!.validate()) {
                                      await userLogin();
                                      passwordController.clear();
                                    }
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
                ],
              ),
            ),
    );
  }
}
