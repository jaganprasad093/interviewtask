import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:interviewtask/model/RegistrationModel.dart';

class registration_controller with ChangeNotifier {
  bool isLoading = false;
  bool uploading = false;
  var collectionReference = FirebaseFirestore.instance.collection("users");
  final storgeRef = FirebaseStorage.instance.ref();

  Registration_model? user;
  List<Registration_model> users_list = [];
  // final ImagePicker picker = ImagePicker();

  File? selectedFile;

  registration_controller() {
    addRegisterListener();
    addUsersList();
  }

  Future<bool> register({
    required BuildContext context,
    String? name,
    String? gender,
    String? dob,
    String? email,
    String? password,
    int? phone,
  }) async {
    try {
      isLoading = true;
      notifyListeners();

      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email ?? "",
        password: password ?? "",
      );
      if (credential.user?.uid != null) {
        collectionReference.doc(credential.user!.uid).set({
          "firstname": name,
          "phoneno": phone,
          "gender": gender,
          "dob": dob,
          "email": email,
          "password": password,
        });

        isLoading = false;
        notifyListeners();
        return true;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text("The password provided is too weak.")));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text("The account already exists for that email.")));
      }
      isLoading = false;
      notifyListeners();
      return false;
    } catch (e) {
      log(e.toString());
      isLoading = false;
      notifyListeners();
      return false;
    }
    isLoading = false;
    notifyListeners();
    return false;
  }

  Future<void> addData(Registration_model registrationModel, String uid) async {
    final data = {
      "name": registrationModel.name,
      "gender": registrationModel.gender,
      "email": registrationModel.email,
      "dob": registrationModel.dob,
      "password": registrationModel.password,
      "image": registrationModel.image,
      "userid": FirebaseAuth.instance.currentUser!.uid,
      "phoneno": registrationModel.phoneno,
      "address": registrationModel.address
    };

    await collectionReference.doc(uid).set(data);
  }

  void addRegisterListener() {
    if (FirebaseAuth.instance.currentUser != null) {
      collectionReference
          .doc(FirebaseAuth.instance.currentUser?.uid ?? "")
          .snapshots()
          .listen((event) {
        final data = event.data();
        if (data != null) {
          user = Registration_model(
            name: data["name"] as String? ?? '',
            gender: data["gender"] as String? ?? '',
            dob: data["dob"] as String? ?? '',
            email: data["email"],
            password: data["password"] as String? ?? '',
            address: data["address"] as String? ?? '',
            phoneno: data["phoneno"] as String? ?? '',
          );
        }
        notifyListeners();
      }, onError: (error) {
        log("Error fetching snapshots: $error");
      });
    }
  }

  void addUsersList() {
    collectionReference.snapshots().listen((event) {
      users_list = event.docs.map((e) {
        final data = e.data();
        return Registration_model(
          name: data["name"] as String? ?? '',
          gender: data["gender"] as String? ?? '',
          dob: data["dob"] as String? ?? '',
          email: data["email"],
          password: data["password"] as String? ?? '',
          address: data["address"] as String? ?? '',
          phoneno: data["phoneno"] as String? ?? '',
        );
      }).toList();
      log("Fetched ${users_list.length} users");
      notifyListeners();
    }, onError: (error) {
      log("Error fetching snapshots: $error");
    });
  }

  Future<void> fetchUserData() async {
    collectionReference
        .where("userid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .orderBy("users", descending: true)
        .snapshots()
        .listen((event) {
      users_list = event.docs
          .map((e) => Registration_model(
                name: e['name'],
                gender: e['gender'],
                dob: e['dob'],
                email: e['email'],
                password: e['password'],
                phoneno: e['phoneno'],
                address: e['adress'],
                image: e['image'],
              ))
          .toList();
      notifyListeners();
    });
  }

  void resetData() {
    users_list.clear();
    user = null;
    notifyListeners();
  }

  updatePhone(Registration_model registration_model) async {
    try {
      await collectionReference
          .doc(FirebaseAuth.instance.currentUser?.uid ?? "")
          .update({
        "phoneno": registration_model.phoneno,
        // "address": registration_model.address,
        // "dob": registration_model.dob,
        // "gender": registration_model.gender
      });
      log(" updated successfully");
    } catch (e) {
      log("Error updating phone number: $e");
    }
  }

  updateAddress(Registration_model registration_model) async {
    try {
      await collectionReference
          .doc(FirebaseAuth.instance.currentUser?.uid ?? "")
          .update({
        // "phoneno": registration_model.phoneno,
        "address": registration_model.address,
        // "dob": registration_model.dob,
        // "gender": registration_model.gender
      });
      log(" updated successfully");
    } catch (e) {
      log("Error updating phone number: $e");
    }
  }

  updateDob(Registration_model registration_model) async {
    try {
      await collectionReference
          .doc(FirebaseAuth.instance.currentUser?.uid ?? "")
          .update({
        // "phoneno": registration_model.phoneno,
        // "address": registration_model.address,
        "dob": registration_model.dob,
        // "gender": registration_model.gender
      });
      log(" updated successfully");
    } catch (e) {
      log("Error updating phone number: $e");
    }
  }

  updateGender(Registration_model registration_model) async {
    try {
      await collectionReference
          .doc(FirebaseAuth.instance.currentUser?.uid ?? "")
          .update({
        // "phoneno": registration_model.phoneno,
        // "address": registration_model.address,
        // "dob": registration_model.dob,
        "gender": registration_model.gender
      });
      log(" updated successfully");
    } catch (e) {
      log("Error updating phone number: $e");
    }
  }
}
