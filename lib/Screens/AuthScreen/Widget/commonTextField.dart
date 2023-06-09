import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CommonTextFieldAuth extends StatefulWidget {
  const CommonTextFieldAuth({
    Key? key,
    required this.commonController,
    required this.commonHintText,
    required this.commonKeyboardType,
    required this.commonOnPressed,
  }) : super(key: key);
  final commonController;
  final commonHintText;
  final commonKeyboardType;
  final commonOnPressed;

  @override
  State<CommonTextFieldAuth> createState() => _CommonTextFieldAuthState();
}

class _CommonTextFieldAuthState extends State<CommonTextFieldAuth> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: widget.commonKeyboardType,
      controller: widget.commonController,
      decoration: InputDecoration(
        constraints: BoxConstraints(maxWidth: 250.sp),
        filled: true,
        fillColor: Colors.grey.shade100,
        hintText: widget.commonHintText,
        suffixIcon: IconButton(
          onPressed: widget.commonOnPressed,
          icon: const Icon(Icons.clear_rounded),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.sp),
          borderSide: BorderSide(color: Colors.grey.shade500),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.sp),
          borderSide: BorderSide(color: Colors.grey.shade500),
        ),
      ),
    );
  }
}
