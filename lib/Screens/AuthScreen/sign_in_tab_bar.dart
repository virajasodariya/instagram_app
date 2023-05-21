import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_app/Controllers/AuthScreenController/email_verify.dart';
import 'package:instagram_app/Controllers/AuthScreenController/variable.dart';
import 'package:instagram_app/Controllers/height_and_width.dart';
import 'package:instagram_app/Screens/AuthScreen/Widget/commonTextField.dart';
import 'package:instagram_app/Screens/AuthScreen/Widget/enter_phone_number.dart';
import 'package:instagram_app/Screens/AuthScreen/enter_otp_screen.dart';
import 'package:instagram_app/Screens/AuthScreen/sign_up_tab_bar.dart';
import 'package:instagram_app/Screens/Widget/commonBoxShadow.dart';
import 'package:instagram_app/Screens/Widget/common_elevated_button.dart';
import 'package:instagram_app/Screens/Widget/common_text_button.dart';

class SignInTabBar extends StatefulWidget {
  const SignInTabBar({Key? key}) : super(key: key);

  @override
  State<SignInTabBar> createState() => _SignInTabBarState();
}

class _SignInTabBarState extends State<SignInTabBar>
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
                  SignInWithPhone(),
                  SignInWithEmail(),
                ],
              ),
            ),
            Container(
              height: height * 0.08,
              width: width,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [kGrey11],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                    ),
                  ),
                  commonTextButton(
                    () {
                      Get.to(
                        () => const SignUpTabBar(),
                      );
                    },
                    "Register",
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

/// sign in with phone number

class SignInWithPhone extends StatefulWidget {
  const SignInWithPhone({Key? key}) : super(key: key);

  @override
  State<SignInWithPhone> createState() => _SignInWithPhoneState();
}

class _SignInWithPhoneState extends State<SignInWithPhone> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: height * 0.03),
        phoneNumberWithCountryCode(),
        SizedBox(height: height * 0.03),
        commonElevatedButton(
          () {
            Get.to(
              () => EnterOtpScreen(
                id: '',
              ),
            );
          },
          "NEXT",
        ),
      ],
    );
  }
}

/// sign in with email

class SignInWithEmail extends StatefulWidget {
  const SignInWithEmail({Key? key}) : super(key: key);

  @override
  State<SignInWithEmail> createState() => _SignInWithEmailState();
}

class _SignInWithEmailState extends State<SignInWithEmail> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: height * 0.05),
        CommonTextFieldAuth(
          commonController: emailController,
          commonHintText: "Enter your email address",
          commonKeyboardType: TextInputType.emailAddress,
          commonOnPressed: () {
            emailController.clear();
          },
        ),
        SizedBox(height: height * 0.03),
        CommonTextFieldAuth(
          commonController: passwordController,
          commonHintText: "Enter your password",
          commonKeyboardType: TextInputType.number,
          commonOnPressed: () {
            passwordController.clear();
          },
        ),
        SizedBox(height: height * 0.05),
        commonElevatedButton(
          () {
            emailVerifySignIn();
          },
          "Log in",
        ),
      ],
    );
  }
}
