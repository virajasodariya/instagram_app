import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:instagram_app/Controllers/AuthScreenController/variable.dart';
import 'package:instagram_app/Screens/HomeScreen/home_screen.dart';

/// crete user code

void emailVerifySignUp() async {
  FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference user = FirebaseFirestore.instance.collection('User');

  try {
    UserCredential credential = await auth.createUserWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );

    log("uid := ${credential.user!.uid}");
    log("email := ${credential.user!.email}");

    user.doc(credential.user!.uid).set({
      "Email": emailController.text,
      "Password": passwordController.text,
    });

    Get.to(
      () => HomeScreen(currentUser: credential.user!.uid),
    );
  } on FirebaseAuthException catch (e) {
    log("ERROR := ${e.code}");

    Get.snackbar(
      "MISTAKE",
      "${e.message}",
    );
  }
}

/// sign in user code

void emailVerifySignIn() async {
  FirebaseAuth auth = FirebaseAuth.instance;

  try {
    UserCredential credential = await auth.signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );

    log("uid := ${credential.user!.uid}");
    log("email := ${credential.user!.email}");

    Get.to(
      HomeScreen(currentUser: credential.user!.uid),
    );
  } on FirebaseAuthException catch (e) {
    log("ERROR := ${e.code}");

    Get.snackbar("MISTAKE", "${e.message}");
  }
}
