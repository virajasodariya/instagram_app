import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_app/Constants/text_style.dart';
import 'package:instagram_app/Controllers/AuthScreenController/email_verify.dart';
import 'package:instagram_app/Controllers/AuthScreenController/phone_verify.dart';
import 'package:instagram_app/Controllers/AuthScreenController/variable.dart';
import 'package:instagram_app/Controllers/height_and_width.dart';
import 'package:instagram_app/Screens/AuthScreen/Widget/commonTextField.dart';
import 'package:instagram_app/Screens/AuthScreen/Widget/phone_number_text_field.dart';
import 'package:instagram_app/Screens/AuthScreen/sign_in_tab_bar.dart';
import 'package:instagram_app/Screens/Widget/common_elevated_button.dart';

class SignUpTabBar extends StatefulWidget {
  const SignUpTabBar({Key? key}) : super(key: key);

  @override
  State<SignUpTabBar> createState() => _SignUpTabBarState();
}

class _SignUpTabBarState extends State<SignUpTabBar>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  List tabText = [
    "PHONE",
    "EMAIL",
  ];

  @override
  void initState() {
    tabController = TabController(length: tabText.length, vsync: this);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: height * 0.4,
              width: width * 0.4,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: width * 0.004,
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.person_outline_outlined,
                size: height * 0.12,
              ),
            ),
            TabBar(
              controller: tabController,
              indicatorSize: TabBarIndicatorSize.label,
              physics: const BouncingScrollPhysics(),
              labelColor: Colors.grey,
              indicatorColor: Colors.black,
              isScrollable: true,
              tabs: List.generate(
                tabText.length,
                (index) => Text("${tabText[index]}"),
              ),
            ),
            SizedBox(
              height: height * 0.49844,
              child: TabBarView(
                controller: tabController,
                children: const [
                  SignUpWithPhoneNumber(),
                  SignUpWithEmail(),
                ],
              ),
            ),
            BottomAppBar(
              shadowColor: Colors.grey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.to(
                        () => const SignInTabBar(),
                      );
                    },
                    child: const Text("Log in."),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// sign up with phone number

class SignUpWithPhoneNumber extends StatefulWidget {
  const SignUpWithPhoneNumber({Key? key}) : super(key: key);

  @override
  State<SignUpWithPhoneNumber> createState() => _SignUpWithPhoneNumberState();
}

class _SignUpWithPhoneNumberState extends State<SignUpWithPhoneNumber> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: height * 0.05),
        phoneNumberWithCountryCode(),
        SizedBox(height: height * 0.05),
        Text(
          textAlign: TextAlign.center,
          "Yoy may receive SMS notification from us for security and"
          "\nlogin purposes.",
          style: kGreyShade500W500,
        ),
        SizedBox(height: height * 0.1),
        commonElevatedButton(
          () {
            sendOtp();
            mobileNumber.clear();
          },
          "Next",
        ),
      ],
    );
  }
}

///  sign up with email

class SignUpWithEmail extends StatefulWidget {
  const SignUpWithEmail({Key? key}) : super(key: key);

  @override
  State<SignUpWithEmail> createState() => _SignUpWithEmailState();
}

class _SignUpWithEmailState extends State<SignUpWithEmail> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: height * 0.05),
        CommonTextFieldAuth(
          commonKeyboardType: TextInputType.emailAddress,
          commonController: emailController,
          commonHintText: "Enter your email",
          commonOnPressed: () {
            emailController.clear();
          },
        ),
        SizedBox(height: height * 0.02),
        CommonTextFieldAuth(
          commonKeyboardType: TextInputType.number,
          commonController: passwordController,
          commonHintText: "Enter your password",
          commonOnPressed: () {
            passwordController.clear();
          },
        ),
        SizedBox(height: height * 0.05),
        commonElevatedButton(
          () {
            emailVerifySignUp();
          },
          "NEXT",
        ),
      ],
    );
  }
}
