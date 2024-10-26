import 'package:flutter/material.dart';
import 'package:interviewtask/controller/registration_controller.dart';
import 'package:interviewtask/core/widgets/custom_button.dart';
import 'package:interviewtask/core/widgets/custom_textfield.dart';
import 'package:interviewtask/model/RegistrationModel.dart';
import 'package:interviewtask/view/register_page/widgets/dob.dart';
import 'package:provider/provider.dart';

class Address extends StatefulWidget {
  const Address({super.key});

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
  TextEditingController address_Controller = TextEditingController();
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
                    maxLines: 3,
                    controller: address_Controller,
                    // minLines: 3,
                    hintText: "Address",
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter the Address';
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
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Custombutton(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      Registration_model updatedUser = Registration_model(
                        address: address_Controller.text,
                      );
                      context
                          .read<registration_controller>()
                          .updateAddress(updatedUser);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DateOfBirth(),
                        ),
                      );
                    }

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DateOfBirth(),
                        ));
                  },
                  provider: context.watch<registration_controller>().isLoading,
                  text: "Next",
                  padding: EdgeInsets.symmetric(vertical: 10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
