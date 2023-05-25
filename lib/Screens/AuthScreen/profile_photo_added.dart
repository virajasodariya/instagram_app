import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_app/Constants/text_style.dart';
import 'package:instagram_app/Screens/HomeScreen/home_screen.dart';
import 'package:instagram_app/Screens/Widget/common_elevated_button.dart';
import 'package:instagram_app/Screens/Widget/common_text_button.dart';
import 'package:sizer/sizer.dart';

class ProfilePhotoAdded extends StatefulWidget {
  const ProfilePhotoAdded({
    Key? key,
    required this.currentUser,
  }) : super(key: key);
  final String currentUser;

  @override
  State<ProfilePhotoAdded> createState() => _ProfilePhotoAddedState();
}

class _ProfilePhotoAddedState extends State<ProfilePhotoAdded> {
  CollectionReference users = FirebaseFirestore.instance.collection('User');
  DocumentReference? user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user =
        FirebaseFirestore.instance.collection('User').doc(widget.currentUser);
  }

  bool switchValue = true;

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
                  SizedBox(height: 70.sp),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100.sp),
                    child: Container(
                      height: 100.sp,
                      width: 100.sp,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 2.sp,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Image.network(
                        snapshot.data!['Image Url'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 30.sp),
                  Text(
                    "Profile photo added",
                    style: FontTextStyle.kBlack20W500,
                  ),
                  commonTextButton(
                    () {},
                    "Change photo",
                  ),
                  SizedBox(height: 30.sp),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Also share this photo as a post",
                        style: FontTextStyle.kBlack12W500,
                      ),
                      Switch(
                          value: switchValue,
                          onChanged: (value) {
                            setState(() {
                              switchValue = value;
                            });
                          }),
                    ],
                  ),
                  SizedBox(height: 15.sp),
                  Text(
                    "Make this photo your first post so people can like and\n"
                    "comment on it.",
                    style: FontTextStyle.kGreyShade50012W500,
                  ),
                  SizedBox(height: 15.sp),
                  commonElevatedButton(
                    () {
                      Get.to(
                        () => HomeScreen(
                          currentUser: widget.currentUser,
                        ),
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
