import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_app/Constants/text_style.dart';
import 'package:instagram_app/Controllers/AuthScreenController/variable.dart';
import 'package:instagram_app/Screens/AuthScreen/Widget/commonTextField.dart';
import 'package:instagram_app/Screens/AuthScreen/add_your_birthday.dart';
import 'package:instagram_app/Screens/Widget/common_elevated_button.dart';
import 'package:instagram_app/Screens/Widget/common_text_button.dart';
import 'package:sizer/sizer.dart';

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
                  SizedBox(height: 100.sp),
                  Text(
                    "NAME AND PASSWORD",
                    style: FontTextStyle.kBlack16W500,
                  ),
                  SizedBox(height: 20.sp),
                  CommonTextFieldAuth(
                    commonController: nameController,
                    commonHintText: "Full name",
                    commonKeyboardType: TextInputType.name,
                    commonOnPressed: () {
                      nameController.clear();
                    },
                  ),
                  SizedBox(height: 10.sp),
                  CommonTextFieldAuth(
                    commonController: passwordController,
                    commonHintText: "Password",
                    commonKeyboardType: TextInputType.number,
                    commonOnPressed: () {
                      passwordController.clear();
                    },
                  ),
                  SizedBox(height: 15.sp),
                  Padding(
                    padding: EdgeInsets.only(left: 15.sp),
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
                          style: FontTextStyle.kGreyShade50012W500,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15.sp),
                  commonElevatedButton(
                    () {
                      contactsPermissionShowDialog(context);
                    },
                    "Continue and sync contacts",
                  ),
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
                  SizedBox(height: 175.sp),
                  Text(
                    textAlign: TextAlign.center,
                    "Your contacts will be periodically synced and stored on\n"
                    "Instagram servers to help you and others find friends, and to\n"
                    "help us provide a better service. To remove contacts, go to\n"
                    "Settings and disconnect.",
                    style: FontTextStyle.kGreyShade50012W500,
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
              SizedBox(height: 15.sp),
              Icon(
                Icons.contacts_outlined,
                color: Colors.blue,
                size: 30.sp,
              ),
              SizedBox(height: 15.sp),
              Text(
                textAlign: TextAlign.center,
                "Allow Instagram to access your\n"
                "contacts?",
                style: FontTextStyle.kBlack16W500,
              ),
              SizedBox(height: 15.sp),
              Divider(thickness: 1.sp),
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
              Divider(thickness: 1.sp),
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
