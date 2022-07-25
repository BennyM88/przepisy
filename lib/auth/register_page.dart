// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({Key? key, required this.showLoginPage}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  var snackBar = SnackBar(
      content: Text('Już istnieje użytkownik o podanym emailu'),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.red);
  var pswdSnackBar = SnackBar(
      content: Text('Podane hasła są różne'),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.red);

  Future<void> signUp() async {
    FocusManager.instance.primaryFocus?.unfocus();

    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    if (passwordConfirmed()) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim());
      } on FirebaseAuthException catch (_) {
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(pswdSnackBar);
    }
  }

  bool passwordConfirmed() {
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
    final size = MediaQuery.of(context).size;
    return Scaffold(
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
                    padding: const EdgeInsets.symmetric(horizontal: 35.0),
                    child: Image.asset('assets/logo.png',
                        width: double.infinity, height: size.height * 0.1),
                  ),
                  SizedBox(height: 20),
                  //email text
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35.0),
                    child: Text('E-MAIL'),
                  ),
                  SizedBox(height: 10),
                  //email textfield
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade500,
                            offset: Offset(1, 2),
                            blurRadius: 8,
                            spreadRadius: 0.5,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: TextFormField(
                          controller: _emailController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (email) =>
                              email != null && !EmailValidator.validate(email)
                                  ? 'Wprowadź poprawny e-mail'
                                  : null,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon:
                                Icon(Icons.mail_outline, color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  //password text
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35.0),
                    child: Text('HASŁO'),
                  ),
                  SizedBox(height: 10),
                  //password textfield
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade500,
                            offset: Offset(1, 2),
                            blurRadius: 8,
                            spreadRadius: 0.5,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) =>
                              value != null && value.length < 6
                                  ? 'Hasło musi mieć minimum 6 znaków'
                                  : null,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon:
                                Icon(Icons.lock_outline, color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  //confirm password text
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35.0),
                    child: Text('POTWIERDŹ'),
                  ),
                  SizedBox(height: 10),
                  //confirm password textfield
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade500,
                            offset: Offset(1, 2),
                            blurRadius: 8,
                            spreadRadius: 0.5,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: TextFormField(
                          controller: _confirmPasswordController,
                          obscureText: true,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) =>
                              value != null && value.length < 6
                                  ? 'Hasło musi mieć minimum 6 znaków'
                                  : null,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon:
                                Icon(Icons.lock_outline, color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  //register button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: GestureDetector(
                      onTap: signUp,
                      child: Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            'ZAREJESTRUJ',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  //login page
                  GestureDetector(
                    onTap: widget.showLoginPage,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'MASZ JUŻ KONTO?',
                          style: TextStyle(fontSize: 16),
                        ),
                        Icon(Icons.arrow_right),
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
