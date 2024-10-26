import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:interviewtask/controller/login_controller.dart';
import 'package:interviewtask/controller/registration_controller.dart';
import 'package:interviewtask/firebase_options.dart';
import 'package:interviewtask/view/homepage/homepage.dart';
import 'package:interviewtask/view/login_page/login.dart';
import 'package:interviewtask/view/register_page/register.dart';
import 'package:interviewtask/view/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(InterviewTask());
}

class InterviewTask extends StatefulWidget {
  const InterviewTask({super.key});

  @override
  State<InterviewTask> createState() => _InterviewTaskState();
}

class _InterviewTaskState extends State<InterviewTask> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => login_controller(),
        ),
        ChangeNotifierProvider(
          create: (context) => registration_controller(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(), // Ensure this is your initial screen
        routes: {
          "/home": (context) => Homepage(),
          "/login": (context) => Login(),
          "/register": (context) => Register(),
        },
      ),
    );
  }
}
