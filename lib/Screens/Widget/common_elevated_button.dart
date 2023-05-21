import 'package:flutter/material.dart';
import 'package:instagram_app/Controllers/height_and_width.dart';

ElevatedButton commonElevatedButton(Function() onTap, String title) {
  return ElevatedButton(
    onPressed: onTap,
    style: ElevatedButton.styleFrom(
      minimumSize: Size(
        width * 0.85,
        height * 0.06,
      ),
    ),
    child: Text(
      title,
    ),
  );
}
