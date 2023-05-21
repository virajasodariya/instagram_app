import 'package:flutter/material.dart';

TextButton commonTextButton(Function() onTap, String title) {
  return TextButton(
    onPressed: onTap,
    child: Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}
