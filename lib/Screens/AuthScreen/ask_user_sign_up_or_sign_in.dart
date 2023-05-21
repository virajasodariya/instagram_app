import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_app/Controllers/height_and_width.dart';
import 'package:instagram_app/Screens/AuthScreen/sign_in_tab_bar.dart';
import 'package:instagram_app/Screens/AuthScreen/sign_up_tab_bar.dart';
import 'package:instagram_app/Screens/Widget/common_elevated_button.dart';
import 'package:instagram_app/Screens/Widget/common_text_button.dart';
import 'package:language_picker/language_picker_dropdown.dart';
import 'package:language_picker/languages.dart';

class AskUserSignUpOrSignIn extends StatefulWidget {
  const AskUserSignUpOrSignIn({Key? key}) : super(key: key);

  @override
  State<AskUserSignUpOrSignIn> createState() => _AskUserSignUpOrSignInState();
}

class _AskUserSignUpOrSignInState extends State<AskUserSignUpOrSignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: height * 0.07),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.32),
              child: LanguagePickerDropdown(
                  initialValue: Languages.english,
                  onValuePicked: (Language language) {
                    log(language.name);
                  }),
            ),
            SizedBox(height: height * 0.23),
            Image.asset(
              "assets/images/Instagram-name-logo.png",
              height: height * 0.2,
              width: width * 0.9,
            ),
            commonElevatedButton(
              () {
                Get.to(
                  () => const SignUpTabBar(),
                );
              },
              "Create new account",
            ),
            SizedBox(height: height * 0.01),
            commonTextButton(
              () {
                Get.to(
                  () => const SignInTabBar(),
                );
              },
              "Log in",
            )
          ],
        ),
      ),
    );
  }
}
