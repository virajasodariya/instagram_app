import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_app/Controllers/height_and_width.dart';
import 'package:instagram_app/Screens/AuthScreen/ask_user_sign_up_or_sign_in.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(
      const Duration(seconds: 3),
      () {
        Get.to(
          () => const AskUserSignUpOrSignIn(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/images/splash_screen_pic.png",
        ),
        Positioned(
          bottom: height * 0.02,
          left: width * 0.25,
          right: width * 0.25,
          child: Image.asset(
            "assets/images/Instagram-name-logo.png",
          ),
        ),
      ],
    );
  }
}
