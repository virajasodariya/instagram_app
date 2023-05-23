import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_app/Constants/text_style.dart';
import 'package:instagram_app/Controllers/AuthScreenController/variable.dart';
import 'package:instagram_app/Controllers/height_and_width.dart';
import 'package:instagram_app/Screens/AuthScreen/add_profile_photo.dart';
import 'package:instagram_app/Screens/Widget/common_elevated_button.dart';

class SignUpWithUserName extends StatefulWidget {
  const SignUpWithUserName({Key? key, required this.currentUser})
      : super(key: key);
  final String currentUser;

  @override
  State<SignUpWithUserName> createState() => _SignUpWithUserNameState();
}

class _SignUpWithUserNameState extends State<SignUpWithUserName> {
  CollectionReference users = FirebaseFirestore.instance.collection('User');

  DocumentReference? user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user =
        FirebaseFirestore.instance.collection('User').doc(widget.currentUser);
  }

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
                  SizedBox(height: height * 0.4),
                  Text(
                    "Sign up as",
                    style: k25W500,
                  ),
                  Text(
                    "${userNameController.text}?",
                    style: k20Bold,
                  ),
                  SizedBox(height: height * 0.02),
                  Text(
                    "You can always change your username later.",
                    style: kGreyShade500W500,
                  ),
                  SizedBox(height: height * 0.05),
                  commonElevatedButton(
                    () {
                      Get.to(
                        () => AddProfilePhoto(currentUser: widget.currentUser),
                      );
                    },
                    "Sign up",
                  ),
                  SizedBox(height: height * 0.26),
                  Text(
                    textAlign: TextAlign.center,
                    "By clicking Next,you agree to our Terms.Learn how we collect,\n"
                    "use and share your data in our Data Policy and how we use\n"
                    "cookies and similar technology in our Cookies Policy.",
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
}
