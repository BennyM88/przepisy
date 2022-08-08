// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:przepisy/constants.dart';
import 'package:przepisy/widgets/custom_button.dart';
import 'package:przepisy/widgets/email_text_field.dart';
import 'package:przepisy/widgets/snack_bar.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  Future<void> _passwordReset() async {
    FocusManager.instance.primaryFocus?.unfocus();

    final bool isValid = formKey.currentState!.validate();
    if (!isValid) return;

    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
    } on FirebaseAuthException catch (_) {
      SnackBarWidget.infoSnackBar(context, 'incorrect_data'.tr, Colors.red);
    }
    SnackBarWidget.infoSnackBar(
        context, 'check_email'.tr, Colors.grey.shade800);
    _emailController.clear();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //logo
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: bigPadding + 5),
                    child: Image.asset('assets/logo.png',
                        width: double.infinity, height: size.height * 0.07),
                  ),
                  const SizedBox(height: 20),
                  //info text
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: bigPadding),
                    child: Text(
                      'enter_email'.tr,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 25),
                  //email text
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: bigPadding + 5),
                    child: Text('E-MAIL'),
                  ),
                  const SizedBox(height: 10),
                  //email textfield
                  emailTextField(_emailController),
                  const SizedBox(height: 50),
                  //reset password button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: bigPadding),
                    child: GestureDetector(
                      onTap: _passwordReset,
                      child: customButton('send'.tr),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
