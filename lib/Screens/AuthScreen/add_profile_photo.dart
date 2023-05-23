import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_app/Constants/text_style.dart';
import 'package:instagram_app/Controllers/height_and_width.dart';
import 'package:instagram_app/Screens/AuthScreen/profile_photo_added.dart';
import 'package:instagram_app/Screens/Widget/common_elevated_button.dart';
import 'package:instagram_app/Screens/Widget/common_text_button.dart';

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
                  SizedBox(height: height * 0.1),
                  GestureDetector(
                    onTap: () {
                      setState(() {});
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            actions: [
                              SizedBox(height: height * 0.025),
                              Center(
                                child: Text(
                                  "Change profile photo",
                                  style: k25W500,
                                ),
                              ),
                              SizedBox(height: height * 0.025),
                              Divider(thickness: height * 0.002),
                              SizedBox(height: height * 0.025),
                              commonTextButton(
                                () {},
                                "Import from Facebook",
                              ),
                              SizedBox(height: height * 0.025),
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
                              SizedBox(height: height * 0.025),
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
                              SizedBox(height: height * 0.025),
                            ],
                          );
                        },
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(height * 0.2),
                      child: Container(
                        height: height * 0.15,
                        width: height * 0.15,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: width * 0.007,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: image == null
                            ? Icon(
                                Icons.camera_alt_outlined,
                                size: height * 0.08,
                              )
                            : Image.file(
                                image!,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.05),
                  Text(
                    "Add profile photo",
                    style: k25W500,
                  ),
                  SizedBox(height: height * 0.05),
                  Text(
                    textAlign: TextAlign.center,
                    "Add a profile photo so your friends know\n"
                    "it's you.",
                    style: kGreyShade500W500,
                  ),
                  SizedBox(height: height * 0.05),
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
