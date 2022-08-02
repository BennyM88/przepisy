import 'package:flutter/material.dart';

class SnackBarWidget {
  SnackBarWidget._();
  static infoSnackBar(BuildContext context, String text, Color color) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(
            content: Text(text),
            duration: const Duration(seconds: 2),
            backgroundColor: color))
        .closed
        .then((value) => ScaffoldMessenger.of(context).clearSnackBars());
  }
}
