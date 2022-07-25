// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:przepisy/auth/forgot_pw_page.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginPage({Key? key, required this.showRegisterPage}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  var snackBar = SnackBar(
      content: Text('Błędne dane, użytkownik nie istnieje'),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.red);

  Future signIn() async {
    FocusManager.instance.primaryFocus?.unfocus();

    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      print(e.message);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future signInWithGoogle() async {
    final GoogleSignInAccount? googleUser =
        await GoogleSignIn(scopes: <String>['email']).signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
                  SizedBox(height: 50),
                  //login button & forgot pswd
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: signIn,
                          child: Container(
                            width: size.width * 0.4,
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                'ZALOGUJ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ForgotPasswordPage()));
                          },
                          child: Text(
                            'Zapomniałeś hasła?',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 25),
                  GestureDetector(
                    onTap: signInWithGoogle,
                    child: Center(
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                            color: Colors.black, shape: BoxShape.circle),
                        child: Image.asset('assets/google.png'),
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  //create a new acc
                  GestureDetector(
                    onTap: widget.showRegisterPage,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'STWÓRZ NOWE KONTO',
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
