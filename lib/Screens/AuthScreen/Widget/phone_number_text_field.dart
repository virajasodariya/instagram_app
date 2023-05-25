import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:instagram_app/Controllers/AuthScreenController/variable.dart';
import 'package:sizer/sizer.dart';

TextField phoneNumberWithCountryCode() {
  return TextField(
    controller: mobileNumber,
    keyboardType: TextInputType.number,
    decoration: InputDecoration(
      prefixIcon: const CountryCodePicker(
        onChanged: print,
        // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
        initialSelection: '+91',
        favorite: ['+91', 'ID'],
        // optional. Shows only country name and flag
        showCountryOnly: false,
        // optional. Shows only country name and flag when popup is closed.
        showOnlyCountryWhenClosed: false,
        // optional. aligns the flag and the Text left
        alignLeft: false,
      ),
      suffixIcon: IconButton(
        onPressed: () {
          mobileNumber.clear();
        },
        icon: const Icon(Icons.cancel_outlined),
      ),
      hintText: "Phone",
      constraints: BoxConstraints(maxWidth: 250.sp),
      filled: true,
      fillColor: Colors.grey.shade100,
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
