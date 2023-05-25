import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_app/Constants/text_style.dart';
import 'package:instagram_app/Screens/AuthScreen/profile_photo_added.dart';
import 'package:instagram_app/Screens/Widget/common_elevated_button.dart';
import 'package:instagram_app/Screens/Widget/common_text_button.dart';
import 'package:sizer/sizer.dart';

class AddProfilePhoto extends StatefulWidget {
  const AddProfilePhoto({
    Key? key,
    required this.currentUser,
  }) : super(key: key);
  final String currentUser;

  @override
  State<AddProfilePhoto> createState() => _AddProfilePhotoState();
}

class _AddProfilePhotoState extends State<AddProfilePhoto> {
  ImagePicker picker = ImagePicker();
  File? image;
  CollectionReference users = FirebaseFirestore.instance.collection('User');
  DocumentReference? user;
  FirebaseStorage storage = FirebaseStorage.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user =
        FirebaseFirestore.instance.collection('User').doc(widget.currentUser);
  }

  bool loading = false;
  String? url;

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
                  SizedBox(height: 75.sp),
                  GestureDetector(
                    onTap: () {
                      setState(() {});
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            actions: [
                              SizedBox(height: 10.sp),
                              Center(
                                child: Text(
                                  "Change profile photo",
                                  style: FontTextStyle.kBlack16W500,
                                ),
                              ),
                              SizedBox(height: 10.sp),
                              Divider(thickness: 2.sp),
                              SizedBox(height: 10.sp),
                              commonTextButton(
                                () {},
                                "Import from Facebook",
                              ),
                              SizedBox(height: 10.sp),
                              commonTextButton(
                                () async {
                                  XFile? file = await picker.pickImage(
                                    source: ImageSource.camera,
                                    imageQuality: 10,
                                  );
                                  image = File(file!.path);
                                  setState(() {});
                                },
                                "Take photo",
                              ),
                              SizedBox(height: 10.sp),
                              commonTextButton(
                                () async {
                                  XFile? file = await picker.pickImage(
                                    source: ImageSource.gallery,
                                    imageQuality: 10,
                                  );
                                  image = File(file!.path);
                                  setState(() {});
                                },
                                "Choose from library",
                              ),
                              SizedBox(height: 10.sp),
                            ],
                          );
                        },
                      );
                    },
                    child: ClipRRect(
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
                        child: image == null
                            ? Icon(
                                Icons.camera_alt_outlined,
                                size: 60.sp,
                              )
                            : Image.file(
                                image!,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30.sp),
                  Text(
                    "Add profile photo",
                    style: FontTextStyle.kBlack20W500,
                  ),
                  SizedBox(height: 30.sp),
                  Text(
                    textAlign: TextAlign.center,
                    "Add a profile photo so your friends know\n"
                    "it's you.",
                    style: FontTextStyle.kGreyShade50012W500,
                  ),
                  SizedBox(height: 30.sp),
                  commonElevatedButton(
                    () async {
                      setState(() {
                        loading = true;
                      });
                      try {
                        await storage
                            .ref('Profile/image')
                            .putFile(image!)
                            .then((p0) async {
                          url = await p0.ref.getDownloadURL();
                          log('URL  $url');
                        });

                        users.doc(widget.currentUser).update({
                          "Image Url": url,
                        });

                        Get.to(
                          () => ProfilePhotoAdded(
                              currentUser: widget.currentUser),
                        );
                      } on FirebaseException catch (e) {
                        log(e.code);
                        Get.snackbar(
                          "MISTAKE",
                          '${e.message}',
                        );
                        setState(() {
                          loading = false;
                        });
                      }
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
