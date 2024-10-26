import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:interviewtask/core/constants/color_constants.dart';
import 'package:interviewtask/view/homepage/homepage.dart';
import 'package:interviewtask/view/login_page/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    initialize();
  }

  Future<void> initialize() async {
    var user = FirebaseAuth.instance.currentUser;
    log("user=$user");

    Future.delayed(Duration(seconds: 3)).then((value) async {
      log("message1");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
      log('isLoggedIn--$isLoggedIn');

      if (isLoggedIn) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Homepage()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.primary_black,
      body: SizedBox.expand(
        child: Image.network(
          "https://images.pexels.com/photos/1337380/pexels-photo-1337380.jpeg?auto=compress&cs=tinysrgb&w=400",
          fit: BoxFit.none,
        ),
      ),
    );
  }
}
