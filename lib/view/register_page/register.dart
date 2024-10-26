import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:interviewtask/controller/registration_controller.dart';
import 'package:interviewtask/core/constants/color_constants.dart';
import 'package:interviewtask/core/widgets/custom_button.dart';
import 'package:interviewtask/core/widgets/custom_textfield.dart';
import 'package:interviewtask/main.dart';
import 'package:interviewtask/model/RegistrationModel.dart';
import 'package:interviewtask/view/login_page/login.dart';
import 'package:interviewtask/view/register_page/widgets/phonenumber.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController name_Controller = TextEditingController();
  TextEditingController email_Controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();
  TextEditingController repass_Controller = TextEditingController();
  TextEditingController phone_Controller = TextEditingController();

  bool invisible = true;
  bool invisible2 = true;
  final _formKey = GlobalKey<FormState>();
  FocusNode focusNode = FocusNode();
  String? email_validate;
  String? mobile_validate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Register",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 40,
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
                    controller: name_Controller,
                    // minLines: 3,
                    hintText: "Name",
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter the name';
                      }
                      if (value.length < 3) {
                        return 'Name must be at least 3 characters long';
                      }

                      RegExp regex = RegExp(r'^[a-zA-Z\s]+$');

                      if (!regex.hasMatch(value)) {
                        return "Please enter a valid name ";
                      }
                    },
                  ),
                  SizedBox(height: 10),
                  CustomTextField(
                    controller: email_Controller,
                    hintText: "Email address",
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the email address';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return "Enter a valid email address";
                      }
                      if (email_validate != null) {
                        return "User with email already exists.";
                      }

                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  CustomTextField(
                    controller: password_controller,
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
                  SizedBox(height: 10),
                  CustomTextField(
                    controller: repass_Controller,
                    hintText: "Confrim Password",
                    isPassword: true,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "re-enter password";
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
                      if (password_controller.text != value) {
                        return 'Passwords do not match';
                      }
                    },
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Custombutton(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        if (password_controller.text ==
                            repass_Controller.text) {
                          try {
                            // Attempt to register the user
                            bool value = await context
                                .read<registration_controller>()
                                .register(
                                  name: name_Controller.text,
                                  email: email_Controller.text,
                                  context: context,
                                  password: password_controller
                                      .text, // Use the same password controller
                                );

                            if (value) {
                              // Add user data to Firestore
                              await context
                                  .read<registration_controller>()
                                  .addData(
                                    Registration_model(
                                      name: name_Controller.text,
                                      email: email_Controller.text,
                                      password: password_controller.text,
                                    ),
                                    FirebaseAuth.instance.currentUser?.uid ??
                                        "",
                                  );

                              // ScaffoldMessenger.of(context)
                              //     .showSnackBar(SnackBar(
                              //   backgroundColor: Colors.green,
                              //   content: Text("Registration successful"),
                              // ));

                              // Navigate to Login page
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Phonenumber()),
                              );
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                backgroundColor: Colors.red,
                                content: Text("Registration failed"),
                              ));
                            }
                          } catch (e) {
                            // Handle any exceptions during registration
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.red,
                              content: Text("Error: ${e.toString()}"),
                            ));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.red,
                            content: Text("Passwords do not match"),
                          ));
                        }
                      }
                    },
                    provider:
                        context.watch<registration_controller>().isLoading,
                    text: "Next",
                    padding: EdgeInsets.symmetric(vertical: 10),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "/login");
                    },
                    child: RichText(
                      text: TextSpan(
                        text: "Already registered? ",
                        style: TextStyle(color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                            text: "Login",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: ColorConstants.button_color,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
