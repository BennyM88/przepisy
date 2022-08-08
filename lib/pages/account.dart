// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:przepisy/pages/account_details.dart';
import 'package:przepisy/pages/auth/auth.dart';

class Account extends StatelessWidget {
  const Account({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return AccountDetails();
            } else {
              return Auth();
            }
          } else {
            return Center(
              child: CircularProgressIndicator(color: Colors.black),
            );
          }
        },
      ),
    );
  }
}
