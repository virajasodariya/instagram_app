import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_app/Constants/text_style.dart';
import 'package:instagram_app/Screens/AuthScreen/create_username.dart';
import 'package:instagram_app/Screens/Widget/common_elevated_button.dart';
import 'package:instagram_app/Screens/Widget/common_text_button.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class AddYourBirthday extends StatefulWidget {
  const AddYourBirthday({
    Key? key,
    required this.currentUser,
  }) : super(key: key);
  final String currentUser;

  @override
  State<AddYourBirthday> createState() => _AddYourBirthdayState();
}

class _AddYourBirthdayState extends State<AddYourBirthday> {
  CollectionReference users = FirebaseFirestore.instance.collection('User');

  DocumentReference? user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user =
        FirebaseFirestore.instance.collection('User').doc(widget.currentUser);
  }

  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: user!.get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Center(
              child: Column(
                children: [
                  SizedBox(height: 120.sp),
                  Text(
                    "Add your birthday",
                    style: FontTextStyle.kBlack20W500,
                  ),
                  SizedBox(height: 30.sp),
                  Text(
                    "This won't be part of your public profile.",
                    style: FontTextStyle.kBlack12W500,
                  ),
                  commonTextButton(
                    () {},
                    "Why do i need to provide my birthday?",
                  ),
                  IconButton(
                    onPressed: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );

                      if (picked != null && picked != selectedDate) {
                        setState(() {
                          selectedDate = picked;
                        });
                      }
                    },
                    icon: const Icon(
                      Icons.update_outlined,
                    ),
                  ),
                  Text(
                    selectedDate != null
                        ? 'Your Birth Date: ${selectedDate.toString().substring(0, 10)}'
                        : 'No Date Selected',
                    style: FontTextStyle.kBlack12W500,
                  ),
                  SizedBox(height: 200.sp),
                  commonElevatedButton(
                    () {
                      users.doc(widget.currentUser).update({
                        "Birthdate": selectedDate.toString().substring(0, 10),
                      });
                      Get.to(
                        () => CreateUserName(currentUser: widget.currentUser),
                      );
                    },
                    "Next",
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
}
