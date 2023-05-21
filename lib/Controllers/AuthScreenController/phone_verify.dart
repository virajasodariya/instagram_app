import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:instagram_app/Controllers/AuthScreenController/variable.dart';
import 'package:instagram_app/Screens/AuthScreen/enter_otp_screen.dart';
import 'package:instagram_app/Screens/HomeScreen/home_screen.dart';

/// send otp
void sendOtp() {
  FirebaseAuth auth = FirebaseAuth.instance;

  try {
    auth.verifyPhoneNumber(
      phoneNumber: '+91 ${mobileNumber.text}',
      verificationCompleted: (phoneAuthCredential) {
        log('VERIFY');
      },
      verificationFailed: (error) {
        log('ERROR');
      },
      codeSent: (verificationId, forceResendingToken) {
        Get.to(
          EnterOtpScreen(id: verificationId),
        );
      },
      codeAutoRetrievalTimeout: (verificationId) {
        log('TIME OUT');
      },
    );
  } on FirebaseAuthException catch (e) {
    log('ERROR := ${e.code}');

    Get.snackbar(
      "MISTAKE",
      '${e.message}',
    );
  }
}

/// verify otp

void verifyOtp(dynamic id) async {
  FirebaseAuth auth = FirebaseAuth.instance;

  try {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: id,
      smsCode: otpController.text,
    );

    UserCredential userCredential = await auth.signInWithCredential(credential);

    log('uid:= ${userCredential.user!.uid}');
    log('Phone Number := ${userCredential.user!.phoneNumber}');
    Get.to(
      HomeScreen(currentUser: userCredential.user!.uid),
    );
  } on FirebaseAuthException catch (e) {
    log('ERROR := ${e.code}');

    Get.snackbar(
      "MISTAKE",
      '${e.message}',
    );
  }
}
