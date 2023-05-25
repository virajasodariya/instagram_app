import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_app/Screens/AuthScreen/sign_in_tab_bar.dart';
import 'package:instagram_app/Screens/AuthScreen/sign_up_tab_bar.dart';
import 'package:instagram_app/Screens/Widget/common_elevated_button.dart';
import 'package:instagram_app/Screens/Widget/common_text_button.dart';
import 'package:language_picker/language_picker_dropdown.dart';
import 'package:language_picker/languages.dart';
import 'package:sizer/sizer.dart';

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
            SizedBox(height: 50.sp),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 90.sp),
              child: LanguagePickerDropdown(
                  initialValue: Languages.english,
                  onValuePicked: (Language language) {
                    log(language.name);
                  }),
            ),
            SizedBox(height: 150.sp),
            Image.asset(
              "assets/images/instagram name black color.png",
              scale: 5.sp,
            ),
            SizedBox(height: 40.sp),
            commonElevatedButton(
              () {
                Get.to(
                  () => const SignUpTabBar(),
                );
              },
              "Create new account",
            ),
            SizedBox(height: 8.sp),
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
