import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_app/Controllers/AuthScreenController/email_verify.dart';
import 'package:instagram_app/Controllers/AuthScreenController/variable.dart';
import 'package:instagram_app/Screens/AuthScreen/Widget/commonTextField.dart';
import 'package:instagram_app/Screens/AuthScreen/Widget/phone_number_text_field.dart';
import 'package:instagram_app/Screens/AuthScreen/sign_up_tab_bar.dart';
import 'package:instagram_app/Screens/Widget/common_elevated_button.dart';
import 'package:instagram_app/Screens/Widget/common_text_button.dart';
import 'package:sizer/sizer.dart';

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
            SizedBox(height: 50.sp),
            Container(
              height: 120.sp,
              width: 120.sp,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 2.sp,
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.person_outline_outlined,
                size: 80.sp,
              ),
            ),
            SizedBox(height: 20.sp),
            TabBar(
              controller: tabController,
              indicatorSize: TabBarIndicatorSize.label,
              labelColor: Colors.grey,
              indicatorColor: Colors.black,
              isScrollable: true,
              tabs: List.generate(
                tabText.length,
                (index) => Text("${tabText[index]}"),
              ),
            ),
            SizedBox(
              height: 378.sp,
              child: TabBarView(
                controller: tabController,
                children: const [
                  SignInWithPhone(),
                  SignInWithEmail(),
                ],
              ),
            ),
            BottomAppBar(
              shadowColor: Colors.grey,
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
        SizedBox(height: 20.sp),
        phoneNumberWithCountryCode(),
        SizedBox(height: 20.sp),
        commonElevatedButton(
          () {
            mobileNumber.clear();
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
        SizedBox(height: 20.sp),
        CommonTextFieldAuth(
          commonController: emailController,
          commonHintText: "Enter your email address",
          commonKeyboardType: TextInputType.emailAddress,
          commonOnPressed: () {
            emailController.clear();
          },
        ),
        SizedBox(height: 10.sp),
        CommonTextFieldAuth(
          commonController: passwordController,
          commonHintText: "Enter your password",
          commonKeyboardType: TextInputType.number,
          commonOnPressed: () {
            passwordController.clear();
          },
        ),
        SizedBox(height: 20.sp),
        commonElevatedButton(
          () {
            emailVerifySignIn();
            emailController.clear();
            passwordController.clear();
          },
          "Log in",
        ),
      ],
    );
  }
}
