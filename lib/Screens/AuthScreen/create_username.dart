import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_app/Constants/text_style.dart';
import 'package:instagram_app/Controllers/AuthScreenController/variable.dart';
import 'package:instagram_app/Screens/AuthScreen/Widget/commonTextField.dart';
import 'package:instagram_app/Screens/AuthScreen/sign_up_with_user_name.dart';
import 'package:instagram_app/Screens/Widget/common_elevated_button.dart';
import 'package:sizer/sizer.dart';

class CreateUserName extends StatefulWidget {
  const CreateUserName({
    Key? key,
    required this.currentUser,
  }) : super(key: key);
  final String currentUser;

  @override
  State<CreateUserName> createState() => _CreateUserNameState();
}

class _CreateUserNameState extends State<CreateUserName> {
  DocumentReference? user;
  CollectionReference users = FirebaseFirestore.instance.collection('User');
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
                  SizedBox(height: 150.sp),
                  Text(
                    "CREATE USERNAME",
                    style: FontTextStyle.kBlack16W500,
                  ),
                  SizedBox(height: 16.sp),
                  Text(
                    textAlign: TextAlign.center,
                    "Add a username or use our suggestion. You can\n"
                    "change this at any time.",
                    style: FontTextStyle.kGreyShade50012W500,
                  ),
                  SizedBox(height: 30.sp),
                  CommonTextFieldAuth(
                    commonController: userNameController,
                    commonHintText: "Enter your user name",
                    commonKeyboardType: TextInputType.name,
                    commonOnPressed: () {
                      userNameController.clear();
                    },
                  ),
                  SizedBox(height: 30.sp),
                  commonElevatedButton(
                    () {
                      users.doc(widget.currentUser).update({
                        "User Name": userNameController.text,
                      });

                      Get.to(
                        () =>
                            SignUpWithUserName(currentUser: widget.currentUser),
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
