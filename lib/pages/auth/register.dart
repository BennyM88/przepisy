import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:przepisy/constants.dart';
import 'package:przepisy/widgets/custom_button.dart';
import 'package:przepisy/widgets/email_text_field.dart';
import 'package:przepisy/widgets/loading.dart';
import 'package:przepisy/widgets/pswd_text_field.dart';

import '../../widgets/snack_bar.dart';

class Register extends StatefulWidget {
  final VoidCallback showLoginPage;
  const Register({Key? key, required this.showLoginPage}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _signUp() async {
    FocusManager.instance.primaryFocus?.unfocus();

    final bool isValid = formKey.currentState!.validate();
    if (!isValid) return;

    _isLoading = true;
    setState(() {});
    if (_passwordConfirmed()) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim());
      } on FirebaseAuthException catch (_) {
        SnackBarWidget.infoSnackBar(context, 'email_in_use'.tr, Colors.red);
      }
      _isLoading = false;
      if (mounted) {
        setState(() {});
      }
    } else {
      SnackBarWidget.infoSnackBar(context, 'different_pswd'.tr, Colors.red);
      _isLoading = false;
      setState(() {});
    }
  }

  bool _passwordConfirmed() {
    if (_passwordController.text.trim() ==
        _confirmPasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: _isLoading
              ? const Loading()
              : SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //logo
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: bigPadding + 5),
                          child: Image.asset('assets/logo.png',
                              width: double.infinity,
                              height: size.height * 0.07),
                        ),
                        const SizedBox(height: 20),
                        //email text
                        const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: bigPadding + 5),
                          child: Text('E-MAIL'),
                        ),
                        const SizedBox(height: 10),
                        //email textfield
                        emailTextField(_emailController),
                        const SizedBox(height: 25),
                        //password text
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: bigPadding + 5),
                          child: Text('pswd'.tr),
                        ),
                        const SizedBox(height: 10),
                        //password textfield
                        pswdTextField(_passwordController),
                        const SizedBox(height: 25),
                        //confirm password text
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: bigPadding + 5),
                          child: Text('confirm'.tr),
                        ),
                        const SizedBox(height: 10),
                        //confirm password textfield
                        pswdTextField(_confirmPasswordController),
                        const SizedBox(height: 50),
                        //register button
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: bigPadding),
                          child: GestureDetector(
                            onTap: _signUp,
                            child: customButton('sign_up'.tr),
                          ),
                        ),
                        const SizedBox(height: 50),
                        //login page
                        GestureDetector(
                          onTap: widget.showLoginPage,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'have_acc'.tr,
                                style: const TextStyle(fontSize: 16),
                              ),
                              const Icon(Icons.arrow_right),
                            ],
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
