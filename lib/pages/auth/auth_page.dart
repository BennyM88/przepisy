import 'package:flutter/material.dart';
import 'package:przepisy/pages/auth/login_page.dart';
import 'package:przepisy/pages/auth/register_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _showLoginPage = true;

  void _toggleScreens() {
    setState(() {
      _showLoginPage = !_showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_showLoginPage) {
      return LoginPage(showRegisterPage: _toggleScreens);
    } else {
      return RegisterPage(showLoginPage: _toggleScreens);
    }
  }
}
