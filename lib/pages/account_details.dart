// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccountDetails extends StatefulWidget {
  const AccountDetails({Key? key}) : super(key: key);

  @override
  State<AccountDetails> createState() => _AccountDetailsState();
}

class _AccountDetailsState extends State<AccountDetails> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //icon
            Center(child: Icon(Icons.person_outline_rounded, size: 100)),
            SizedBox(height: 50),
            //email title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                'Adres e-mail',
                style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
              ),
            ),
            SizedBox(height: 5),
            //user email
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                user.email!,
                style: TextStyle(fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Divider(
                color: Colors.black,
                thickness: 1,
              ),
            ),
            SizedBox(height: 20),
            //date title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                'Data założenia',
                style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
              ),
            ),
            SizedBox(height: 5),
            //user date
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Row(
                children: [
                  Text(
                    user.metadata.creationTime!.year.toString(),
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    ' - ',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    user.metadata.creationTime!.month.toString(),
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Divider(
                color: Colors.black,
                thickness: 1,
              ),
            ),
            SizedBox(height: 30),
            //logout button
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                icon: Icon(Icons.logout_rounded),
                label: Text('WYLOGUJ'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
