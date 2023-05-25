import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

ElevatedButton commonElevatedButton(Function() onTap, String title) {
  return ElevatedButton(
    onPressed: onTap,
    style: ElevatedButton.styleFrom(
      minimumSize: Size(
        250.sp,
        40.sp,
      ),
    ),
    child: Text(
      title,
    ),
  );
}
