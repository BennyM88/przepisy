import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:przepisy/constants.dart';

Widget pswdTextField(controller) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: bigPadding),
    child: Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade500,
            offset: const Offset(1, 2),
            blurRadius: 8,
            spreadRadius: 0.5,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 5),
        child: TextFormField(
          controller: controller,
          obscureText: true,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) =>
              value != null && value.length < 6 ? 'pswd_length'.tr : null,
          decoration: const InputDecoration(
            border: InputBorder.none,
            prefixIcon: Icon(Icons.lock_outline, color: Colors.black),
          ),
        ),
      ),
    ),
  );
}
