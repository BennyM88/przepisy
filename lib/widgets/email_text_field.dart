import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:przepisy/constants.dart';

Widget emailTextField(controller) {
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
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (email) => email != null && !EmailValidator.validate(email)
              ? 'incorrect_email'.tr
              : null,
          decoration: const InputDecoration(
            border: InputBorder.none,
            prefixIcon: Icon(Icons.mail_outline, color: Colors.black),
          ),
        ),
      ),
    ),
  );
}
