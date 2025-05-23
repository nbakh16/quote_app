import 'package:flutter/material.dart';

void mySnackBar(
  BuildContext context, {
  required String message,
  Color bgColor = Colors.redAccent,
}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    elevation: 8,
    duration: const Duration(seconds: 2),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    padding: const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 20,
    ),
    backgroundColor: bgColor,
    content: Text(
      message,
      maxLines: 5,
      style:
          Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white),
    ),
  ));
}
