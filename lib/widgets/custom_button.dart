import 'package:flutter/material.dart';

Widget customButton(String text) {
  return Container(
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Center(
      child: Text(
        text,
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
      ),
    ),
  );
}
