import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_app/Constants/text_style.dart';
import 'package:instagram_app/Controllers/height_and_width.dart';
import 'package:instagram_app/Screens/HomeScreen/home_screen.dart';
import 'package:instagram_app/Screens/Widget/common_elevated_button.dart';
import 'package:instagram_app/Screens/Widget/common_text_button.dart';

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
                  SizedBox(height: height * 0.1),
                  Container(
                    height: height * 0.15,
                    width: height * 0.15,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: width * 0.007,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Image.network(
                      snapshot.data!['Image Url'],
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: height * 0.05),
                  Text(
                    "Profile photo added",
                    style: k25W500,
                  ),
                  commonTextButton(
                    () {},
                    "Change photo",
                  ),
                  SizedBox(height: height * 0.05),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Also share this photo as a post",
                        style: k20Bold,
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
                  SizedBox(height: height * 0.03),
                  Text(
                    "Make this photo your first post so people can like and\n"
                    "comment on it.",
                    style: kGreyShade500W500,
                  ),
                  SizedBox(height: height * 0.03),
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
