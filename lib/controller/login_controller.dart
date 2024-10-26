import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:interviewtask/view/homepage/homepage.dart';

class login_controller with ChangeNotifier {
  bool isLoading = false;

  Future<bool> login({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      isLoading = true;
      notifyListeners();

      // Attempt to sign in the user
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Check if the user is successfully signed in
      if (credential.user?.uid != null) {
        isLoading = false;
        notifyListeners();

        // Navigate to the HomePage after successful login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Homepage()),
        );

        return true; // Return true indicating a successful login
      }
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase authentication errors
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text("No user found for that email."),
        ));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text('Wrong password provided for that user.'),
        ));
      }
      isLoading = false;
      notifyListeners();
      return false;
    } catch (e) {
      print(e);
      isLoading = false;
      notifyListeners();
      return false;
    }

    isLoading = false;
    notifyListeners();
    return false;
  }
}
