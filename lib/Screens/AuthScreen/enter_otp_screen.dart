import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_app/Controllers/AuthScreenController/phone_verify.dart';
import 'package:instagram_app/Controllers/AuthScreenController/variable.dart';
import 'package:instagram_app/Controllers/height_and_width.dart';
import 'package:instagram_app/Screens/AuthScreen/Widget/commonTextField.dart';
import 'package:instagram_app/Screens/AuthScreen/enter_name_and_password.dart';
import 'package:instagram_app/Screens/AuthScreen/sign_in_tab_bar.dart';
import 'package:instagram_app/Screens/Widget/common_elevated_button.dart';
import 'package:instagram_app/Screens/Widget/common_text_button.dart';

class EnterOtpScreen extends StatefulWidget {
  const EnterOtpScreen({
    Key? key,
    required this.id,
  }) : super(key: key);
  final String id;

  @override
  State<EnterOtpScreen> createState() => _EnterOtpScreenState();
}

class _EnterOtpScreenState extends State<EnterOtpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: height * 0.1),
          Text(
            textAlign: TextAlign.center,
            "Enter the Confirmation Code We"
            "\nSent to +91 ${mobileNumber.text}",
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
          SizedBox(height: height * 0.1),
          CommonTextFieldAuth(
            commonController: otpController,
            commonHintText: "Confirmation code",
            commonKeyboardType: TextInputType.number,
            commonOnPressed: () {
              otpController.clear();
            },
          ),
          SizedBox(height: height * 0.1),
          commonElevatedButton(
            () {
              verifyOtp(widget.id);
              Get.to(
                () => const EnterNameAndPassword(),
              );
            },
            "NEXT",
          ),
        ],
      ),
    );
  }
}
