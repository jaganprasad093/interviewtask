import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:interviewtask/controller/registration_controller.dart';
import 'package:interviewtask/core/widgets/custom_button.dart';
import 'package:interviewtask/core/widgets/custom_textfield.dart';
import 'package:interviewtask/model/RegistrationModel.dart';
import 'package:interviewtask/view/register_page/widgets/address.dart';
import 'package:provider/provider.dart';

class Phonenumber extends StatefulWidget {
  const Phonenumber({super.key});

  @override
  State<Phonenumber> createState() => _PhonenumberState();
}

class _PhonenumberState extends State<Phonenumber> {
  TextEditingController phone_Controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 80,
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
                    // prefixText: "+91 ",

                    keyboardType: TextInputType.number,
                    prefix: Text(
                      "   🇮🇳 +91   ",
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                    ),

                    controller: phone_Controller,
                    maxLength: 10,
                    hintText: "Phone number",
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter the phone number';
                      }
                      RegExp regex = RegExp(r'^\+?[0-9]{10,15}$');
                      if (!regex.hasMatch(phone_Controller.text)) {
                        return "Enter a valid phone number";
                      }
                      return null;
                    },
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Custombutton(
                  onTap: () {
                    log("phone no---${phone_Controller.text}");

                    if (_formKey.currentState!.validate()) {
                      Registration_model updatedUser = Registration_model(
                        phoneno: phone_Controller.text,
                      );
                      context
                          .read<registration_controller>()
                          .updatePhone(updatedUser);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Address(),
                        ),
                      );
                    }
                  },
                  provider: context.watch<registration_controller>().isLoading,
                  text: "Next",
                  padding: EdgeInsets.symmetric(vertical: 10),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
