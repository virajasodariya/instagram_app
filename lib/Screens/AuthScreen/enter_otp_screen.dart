import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_app/Constants/text_style.dart';
import 'package:instagram_app/Controllers/AuthScreenController/phone_verify.dart';
import 'package:instagram_app/Controllers/AuthScreenController/variable.dart';
import 'package:instagram_app/Screens/AuthScreen/Widget/commonTextField.dart';
import 'package:instagram_app/Screens/AuthScreen/sign_in_tab_bar.dart';
import 'package:instagram_app/Screens/Widget/common_elevated_button.dart';
import 'package:instagram_app/Screens/Widget/common_text_button.dart';
import 'package:sizer/sizer.dart';

class EnterOtpScreen extends StatefulWidget {
  const EnterOtpScreen({
    Key? key,
    this.id,
  }) : super(key: key);
  final id;

  @override
  State<EnterOtpScreen> createState() => _EnterOtpScreenState();
}

class _EnterOtpScreenState extends State<EnterOtpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 75.sp),
            Text(
              textAlign: TextAlign.center,
              "Enter the Confirmation Code We"
              "\nSent to +91 ${mobileNumber.text}",
              style: FontTextStyle.kBlack16W500,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                commonTextButton(
                  () {
                    Get.to(
                      () => const SignInTabBar(),
                    );
                  },
                  "Change phone number",
                ),
                const Text(
                  "or",
                ),
                commonTextButton(
                  () {},
                  "resend SMS",
                ),
              ],
            ),
            SizedBox(height: 15.sp),
            CommonTextFieldAuth(
              commonController: otpController,
              commonHintText: "Confirmation code",
              commonKeyboardType: TextInputType.number,
              commonOnPressed: () {
                otpController.clear();
              },
            ),
            SizedBox(height: 15.sp),
            commonElevatedButton(
              () {
                verifyOtp(widget.id);
              },
              "NEXT",
            ),
            SizedBox(height: 315.sp),
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
