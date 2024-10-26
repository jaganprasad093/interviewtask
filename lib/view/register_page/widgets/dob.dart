import 'package:flutter/material.dart';
import 'package:interviewtask/controller/registration_controller.dart';
import 'package:interviewtask/core/widgets/custom_button.dart';
import 'package:interviewtask/core/widgets/custom_textfield.dart';
import 'package:interviewtask/model/RegistrationModel.dart';
import 'package:interviewtask/view/register_page/widgets/profilePic.dart';
import 'package:provider/provider.dart';

class DateOfBirth extends StatefulWidget {
  const DateOfBirth({super.key});
  @override
  State<DateOfBirth> createState() => _DateOfBirthState();
}

class _DateOfBirthState extends State<DateOfBirth> {
  TextEditingController date_Controller = TextEditingController();
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
                    readOnly: true,
                    suffixIcon: Icon(Icons.calendar_month_rounded),
                    onTap: () => selectDate(context, date_Controller),
                    controller: date_Controller,
                    hintText: "Date of birth",
                    validator: (String? value) {
                      return (value == null || value.isEmpty)
                          ? 'Select date of birth'
                          : null;
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
                        dob: date_Controller.text,
                      );
                      context
                          .read<registration_controller>()
                          .updateDob(updatedUser);
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
      ),
    );
  }

  DateTime selectedDate = DateTime(2015, 12, 31);

  Future<void> selectDate(
    BuildContext context,
    TextEditingController controller,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2015, 12, 31),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blue,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.blue,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        String formattedDate =
            "${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year.toString()}";
        controller.value = TextEditingValue(text: formattedDate);
      });
    } else {
      String formattedDate =
          "${selectedDate.day.toString().padLeft(2, '0')}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.year.toString()}";
      controller.value = TextEditingValue(text: formattedDate);
    }
  }
}
