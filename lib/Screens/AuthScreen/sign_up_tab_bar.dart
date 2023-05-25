import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_app/Constants/text_style.dart';
import 'package:instagram_app/Controllers/AuthScreenController/email_verify.dart';
import 'package:instagram_app/Controllers/AuthScreenController/phone_verify.dart';
import 'package:instagram_app/Controllers/AuthScreenController/variable.dart';
import 'package:instagram_app/Screens/AuthScreen/Widget/commonTextField.dart';
import 'package:instagram_app/Screens/AuthScreen/Widget/phone_number_text_field.dart';
import 'package:instagram_app/Screens/AuthScreen/sign_in_tab_bar.dart';
import 'package:instagram_app/Screens/Widget/common_elevated_button.dart';
import 'package:instagram_app/Screens/Widget/common_text_button.dart';
import 'package:sizer/sizer.dart';

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
                  commonTextButton(() {
                    Get.to(
                      () => const SignInTabBar(),
                    );
                  }, "Log in."),
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
        SizedBox(height: 20.sp),
        phoneNumberWithCountryCode(),
        SizedBox(height: 20.sp),
        Text(
          textAlign: TextAlign.center,
          "You may receive SMS notification from us for security and"
          "\nlogin purposes.",
          style: FontTextStyle.kGreyShade50012W500,
        ),
        SizedBox(height: 20.sp),
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
        SizedBox(height: 20.sp),
        CommonTextFieldAuth(
          commonKeyboardType: TextInputType.emailAddress,
          commonController: emailController,
          commonHintText: "Enter your email",
          commonOnPressed: () {
            emailController.clear();
          },
        ),
        SizedBox(height: 10.sp),
        CommonTextFieldAuth(
          commonKeyboardType: TextInputType.number,
          commonController: passwordController,
          commonHintText: "Enter your password",
          commonOnPressed: () {
            passwordController.clear();
          },
        ),
        SizedBox(height: 20.sp),
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
