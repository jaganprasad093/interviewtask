import 'package:flutter/material.dart';
import 'package:interviewtask/controller/registration_controller.dart';
import 'package:interviewtask/core/constants/color_constants.dart';
import 'package:interviewtask/core/widgets/custom_alerdialog.dart';
import 'package:interviewtask/core/widgets/custom_button.dart';
import 'package:interviewtask/view/homepage/homepage.dart';
import 'package:provider/provider.dart';

class profilePic extends StatefulWidget {
  const profilePic({super.key});

  @override
  State<profilePic> createState() => _profilePicState();
}

class _profilePicState extends State<profilePic> {
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
                  height: 180,
                ),
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 70,
                      backgroundImage: NetworkImage(
                          "https://images.pexels.com/photos/1337380/pexels-photo-1337380.jpeg?auto=compress&cs=tinysrgb&w=400"),
                    ),
                    Positioned(
                        right: 10,
                        bottom: 0,
                        child: Icon(
                          size: 30,
                          Icons.camera_alt_outlined,
                          color: Colors.grey,
                        ))
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Add profile picture",
                  style: TextStyle(
                      color: ColorConstants.button_color,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Custombutton(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Homepage(),
                      ));
                  CustomDialog().showDialogWithFields(context, () {
                    Navigator.pop(context);
                  }, "Welcome to homepage", "Submit");
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
