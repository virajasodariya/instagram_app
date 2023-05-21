import 'package:flutter/material.dart';
import 'package:instagram_app/Controllers/AuthScreenController/variable.dart';
import 'package:instagram_app/Controllers/height_and_width.dart';
import 'package:instagram_app/Screens/AuthScreen/Widget/commonTextField.dart';
import 'package:instagram_app/Screens/Widget/common_text_style.dart';

class EnterNameAndPassword extends StatefulWidget {
  const EnterNameAndPassword({Key? key}) : super(key: key);

  @override
  State<EnterNameAndPassword> createState() => _EnterNameAndPasswordState();
}

class _EnterNameAndPasswordState extends State<EnterNameAndPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: height * 0.15),
            Text(
              "NAME AND PASSWORD",
              style: k20W500,
            ),
            SizedBox(height: height * 0.15),
            CommonTextFieldAuth(
              commonController: nameController,
              commonHintText: "Full name",
              commonKeyboardType: TextInputType.name,
              commonOnPressed: () {
                setState(() {
                  nameController.clear();
                });
              },
            ),
            SizedBox(height: height * 0.15),
          ],
        ),
      ),
    );
  }
}
