import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_app/Constants/text_style.dart';
import 'package:instagram_app/Controllers/AuthScreenController/variable.dart';
import 'package:instagram_app/Controllers/height_and_width.dart';
import 'package:instagram_app/Screens/AuthScreen/Widget/commonTextField.dart';
import 'package:instagram_app/Screens/AuthScreen/add_your_birthday.dart';
import 'package:instagram_app/Screens/Widget/common_elevated_button.dart';
import 'package:instagram_app/Screens/Widget/common_text_button.dart';

class EnterNameAndPassword extends StatefulWidget {
  const EnterNameAndPassword({
    Key? key,
    required this.currentUser,
  }) : super(key: key);

  final String currentUser;

  @override
  State<EnterNameAndPassword> createState() => _EnterNameAndPasswordState();
}

class _EnterNameAndPasswordState extends State<EnterNameAndPassword> {
  CollectionReference users = FirebaseFirestore.instance.collection('User');

  DocumentReference? user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user =
        FirebaseFirestore.instance.collection('User').doc(widget.currentUser);
  }

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: user!.get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: height * 0.15),
                  Text(
                    "NAME AND PASSWORD",
                    style: k20Bold,
                  ),
                  SizedBox(height: height * 0.05),
                  CommonTextFieldAuth(
                    commonController: nameController,
                    commonHintText: "Full name",
                    commonKeyboardType: TextInputType.name,
                    commonOnPressed: () {
                      nameController.clear();
                    },
                  ),
                  SizedBox(height: height * 0.02),
                  CommonTextFieldAuth(
                    commonController: passwordController,
                    commonHintText: "Password",
                    commonKeyboardType: TextInputType.number,
                    commonOnPressed: () {
                      passwordController.clear();
                    },
                  ),
                  SizedBox(height: height * 0.02),
                  Padding(
                    padding: EdgeInsets.only(left: width * 0.04),
                    child: Row(
                      children: [
                        Checkbox(
                          value: isChecked,
                          onChanged: (value) {
                            setState(() {
                              isChecked = value!;
                            });
                          },
                        ),
                        Text(
                          "Remember password ",
                          style: TextStyle(
                            fontSize: height * 0.016,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  commonElevatedButton(
                    () {
                      contactsPermissionShowDialog(context);
                    },
                    "Continue and sync contacts",
                  ),
                  SizedBox(height: height * 0.015),
                  commonTextButton(
                    () {
                      users.doc(widget.currentUser).update({
                        "Full Name": nameController.text,
                        "Password": passwordController.text,
                      });

                      log(nameController.text);
                      log(passwordController.text);

                      Get.to(
                        () => AddYourBirthday(currentUser: widget.currentUser),
                      );
                    },
                    "Continue without syncing contacts",
                  ),
                  SizedBox(height: height * 0.25),
                  Text(
                    textAlign: TextAlign.center,
                    "Your contacts will be periodically synced and stored on\n"
                    "Instagram servers to help you and others find friends, and to\n"
                    "help us provide a better service. To remove contacts, go to\n"
                    "Settings and disconnect.",
                    style: kGreyShade500W500,
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Future<dynamic> contactsPermissionShowDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: height * 0.02),
              Icon(
                Icons.contacts_outlined,
                color: Colors.blue,
                size: height * 0.03,
              ),
              SizedBox(height: height * 0.02),
              Text(
                textAlign: TextAlign.center,
                "Allow Instagram to access your\n"
                "contacts?",
                style: k20Bold,
              ),
              SizedBox(height: height * 0.02),
              Divider(thickness: height * 0.002),
              commonTextButton(
                () {
                  users.doc(widget.currentUser).update({
                    "Full Name": nameController.text,
                    "Password": passwordController.text,
                  });
                  Get.to(
                    () => AddYourBirthday(currentUser: widget.currentUser),
                  );
                },
                "Allow",
              ),
              Divider(thickness: height * 0.002),
              commonTextButton(
                () {
                  users.doc(widget.currentUser).update({
                    "Full Name": nameController.text,
                    "Password": passwordController.text,
                  });
                  Get.to(
                    () => AddYourBirthday(currentUser: widget.currentUser),
                  );
                },
                "Don't allow",
              ),
            ],
          ),
        );
      },
    );
  }
}
