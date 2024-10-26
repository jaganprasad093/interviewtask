import 'package:flutter/material.dart';
import 'package:interviewtask/controller/registration_controller.dart';
import 'package:interviewtask/core/constants/color_constants.dart';
import 'package:interviewtask/view/login_page/login.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    var provider = context.watch<registration_controller>().user;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: SizedBox(),
          title: Text(
            "Homepage",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Name",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.primary_black.withOpacity(.5),
                    fontSize: 16),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                provider?.name ?? "Not entered !",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.primary_black,
                    fontSize: 19),
              ),
              Divider(),
              SizedBox(
                height: 20,
              ),
              Text(
                "Phone No.",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.primary_black.withOpacity(.5),
                    fontSize: 16),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                provider?.phoneno ?? "Not entered !",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.primary_black,
                    fontSize: 19),
              ),
              Divider(),
              SizedBox(
                height: 20,
              ),
              Text(
                "Email",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.primary_black.withOpacity(.5),
                    fontSize: 16),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                provider?.email ?? "Not entered !",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.primary_black,
                    fontSize: 19),
              ),
              Divider(),
              SizedBox(
                height: 20,
              ),
              Text(
                "DOB",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.primary_black.withOpacity(.5),
                    fontSize: 16),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                provider?.dob ?? "Not entered !",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.primary_black,
                    fontSize: 19),
              ),
              Divider(),
              SizedBox(
                height: 20,
              ),
              Text(
                "Gender",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.primary_black.withOpacity(.5),
                    fontSize: 16),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                provider?.gender ?? "Not entered !",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.primary_black,
                    fontSize: 19),
              ),
              Divider(),
              SizedBox(
                height: 180,
              ),
              Center(
                  child: InkWell(
                onTap: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.clear();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Login(),
                      ));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Logout",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                        fontSize: 20),
                  ),
                ),
              ))
            ],
          ),
        ));
  }
}
