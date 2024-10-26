import 'package:flutter/material.dart';
import 'package:interviewtask/controller/registration_controller.dart';
import 'package:interviewtask/core/widgets/custom_button.dart';
import 'package:interviewtask/model/RegistrationModel.dart';
import 'package:interviewtask/view/register_page/widgets/profilePic.dart';
import 'package:provider/provider.dart';

class Gender extends StatefulWidget {
  const Gender({super.key});

  @override
  State<Gender> createState() => _GenderState();
}

class _GenderState extends State<Gender> {
  // TextEditingController address_Controller = TextEditingController();
  final List<String> gender = [
    "Male",
    "Female",
  ];
  String? selectedGender;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
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
                DropdownButtonFormField<String>(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    focusedBorder: OutlineInputBorder(),
                    hintText: "Select gender",
                    hintStyle: TextStyle(
                      textBaseline: TextBaseline.alphabetic,
                      height: 2,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  value:
                      selectedGender != null && gender.contains(selectedGender)
                          ? selectedGender
                          : null,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedGender = newValue;
                    });
                  },
                  items: gender.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  validator: (String? value) {
                    return (value == null || value.isEmpty)
                        ? 'Select gender'
                        : null;
                  },
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Custombutton(
                onTap: () {
                  Registration_model updatedUser = Registration_model(
                    gender: selectedGender,
                  );
                  context
                      .read<registration_controller>()
                      .updateGender(updatedUser);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => profilePic(),
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
    );
  }
}
