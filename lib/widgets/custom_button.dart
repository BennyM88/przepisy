import 'package:flutter/material.dart';
import 'package:przepisy/constants.dart';

Widget customButton(String text) {
  return Container(
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(
      color: primaryColor,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Center(
      child: Text(
        text,
        style: const TextStyle(
            color: secondaryColor, fontWeight: FontWeight.bold, fontSize: 14),
      ),
    ),
  );
}
