import 'dart:ffi';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:interviewtask/view/login_page/login.dart';

class Otp_verification extends StatefulWidget {
  const Otp_verification({super.key});

  @override
  State<Otp_verification> createState() => _Otp_verificationState();
}

class _Otp_verificationState extends State<Otp_verification> {
  TextEditingController otp_controller = TextEditingController();
  EmailOTP myauth = EmailOTP();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios_new_outlined)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(padding: EdgeInsets.symmetric(horizontal: 20)),
              Text(
                "Email is sent",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              SizedBox(
                height: 10,
              ),
              Text("We have sent reset link to email"),
              SizedBox(),
              Image.network(
                  "https://img.freepik.com/premium-vector/unlock-password-correct-success-login-concept-vector-illustration-flat-design_662353-282.jpg"),
              SizedBox(
                height: 50,
              ),
              // TextField(
              //   controller: otp_controller,
              //   decoration: InputDecoration(
              //       hintText: "enter the otp", border: OutlineInputBorder()),
              // ),
              SizedBox(
                height: 50,
              ),
              Center(
                child: Container(
                  height: 50,
                  width: 300,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: InkWell(
                      onTap: () async {
                        // if (await myauth.verifyOTP(otp: otp_controller.text) ==
                        //     true) {
                        //   ScaffoldMessenger.of(context)
                        //       .showSnackBar(const SnackBar(
                        //     content: Text("OTP is verified"),
                        //   ));
                        //   Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //         builder: (context) => New_password(),
                        //       ));
                        // } else {
                        //   ScaffoldMessenger.of(context)
                        //       .showSnackBar(const SnackBar(
                        //     content: Text("Invalid OTP"),
                        //   ));
                        // }
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Login(),
                            ));
                      },
                      child: Text(
                        "Back to Login",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
