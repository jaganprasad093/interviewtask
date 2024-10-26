// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:interviewtask/controller/login_controller.dart';
import 'package:interviewtask/core/constants/color_constants.dart';
import 'package:provider/provider.dart';

class Custombutton extends StatelessWidget {
  final String text;
  final double? fontSize;
  final bool? provider;
  final Function()? onTap;
  final EdgeInsetsGeometry? padding;
  const Custombutton({
    Key? key,
    required this.text,
    this.onTap,
    this.padding,
    this.fontSize,
    this.provider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return InkWell(
          onTap: onTap,
          child: Container(
            padding: padding,
            // height: padding == null ? 50 : 0,
            // width: 200,
            decoration: BoxDecoration(
              color: ColorConstants.button_color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: provider == true
                  ? CircularProgressIndicator(
                      color: ColorConstants.primary_white,
                    )
                  : Text(
                      text,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: fontSize == null ? 20 : fontSize,
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}
