import 'package:flutter/material.dart';
import 'package:przepisy/pages/auth/login.dart';
import 'package:przepisy/pages/auth/register.dart';

class Auth extends StatefulWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  bool _showLoginPage = true;

  void _toggleScreens() {
    setState(() {
      _showLoginPage = !_showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_showLoginPage) {
      return Login(showRegisterPage: _toggleScreens);
    } else {
      return Register(showLoginPage: _toggleScreens);
    }
  }
}
