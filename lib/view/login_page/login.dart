import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:interviewtask/controller/login_controller.dart';
import 'package:interviewtask/core/constants/color_constants.dart';
import 'package:interviewtask/core/widgets/custom_button.dart';
import 'package:interviewtask/core/widgets/custom_textfield.dart';
import 'package:interviewtask/view/homepage/homepage.dart';
import 'package:interviewtask/view/login_page/forgot_password/forgot_password.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);

  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool invisible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 150,
                ),
                CircleAvatar(
                  radius: 70,
                  backgroundImage: NetworkImage(
                      "https://images.pexels.com/photos/1337380/pexels-photo-1337380.jpeg?auto=compress&cs=tinysrgb&w=400"),
                ),
                SizedBox(
                  height: 40,
                ),
                CustomTextField(
                  // errorText: context.watch<RegisterController>().loginErrorMsg,
                  controller: emailController,
                  hintText: "Email address",
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the email address';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return "Enter a valid email address";
                    }

                    return null;
                  },
                ),
                SizedBox(height: 20),
                CustomTextField(
                  controller: passwordController,
                  hintText: "Password",
                  isPassword: true,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter password';
                    }
                    if (value.length < 8) {
                      return "Password must be at least 8 characters long";
                    }
                    if (!RegExp(r'[A-Z]').hasMatch(value)) {
                      return "Password must contain at least one uppercase letter";
                    }

                    if (!RegExp(r'[a-z]').hasMatch(value)) {
                      return "Password must contain at least one lowercase letter";
                    }
                    final RegExp regSpecial = RegExp(r'[!@#\$&*~]');
                    if (!regSpecial.hasMatch(value)) {
                      return "Password must contain at least one special charater";
                    }
                    if (!RegExp(r'[0-9]').hasMatch(value)) {
                      return "Password must contain at least one number";
                    }
                  },
                ),
                SizedBox(
                  height: 60,
                ),
                Custombutton(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      context
                          .read<login_controller>()
                          .login(
                            context: context,
                            email: emailController.text,
                            password: passwordController.text,
                          )
                          .then((value) async {
                        log("value:$value");
                        if (value == true) {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          await prefs.setBool('isLoggedIn', true);

                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.green,
                            content: Text("Login success"),
                          ));

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => Homepage()),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.red,
                            content: Text("Incorrect password or email"),
                          ));
                        }
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.red,
                        content: Text("Enter valid email and password"),
                      ));
                    }
                  },
                  provider: context.watch<login_controller>().isLoading,
                  text: "Login",
                  padding: EdgeInsets.symmetric(vertical: 10),
                ),
                SizedBox(
                  height: 20,
                ),
                // InkWell(
                //   onTap: () async {
                //     try {
                //       await signInWithGoogle();
                //     } catch (e) {
                //       print("Error during Google login: $e");
                //     }
                //   },
                //   child: Container(
                //     height: 50,
                //     // width: 200,
                //     decoration: BoxDecoration(
                //       color: Colors.blue,
                //       borderRadius: BorderRadius.circular(10),
                //     ),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         Padding(
                //           padding: const EdgeInsets.all(15),
                //           child: Container(
                //             child: Image.asset("assets/images/google_icon.png"),
                //           ),
                //         ),
                //         Center(
                //           child: Text(
                //             "Google Login",
                //             style: TextStyle(
                //               color: Colors.white,
                //               fontWeight: FontWeight.bold,
                //               fontSize: 18,
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   height: 40,
                // ),
                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ForgotPassword(),
                          ));
                    },
                    child: Text("Forgot password?")),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: "Don't have an account? ",
                        style: TextStyle(color: Colors.black),
                        children: <TextSpan>[],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, "/register");
                      },
                      child: Text(
                        "Register",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ColorConstants.button_color,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
