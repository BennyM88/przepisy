import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:przepisy/constants.dart';

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
            const Center(child: Icon(Icons.person_outline_rounded, size: 100)),
            const SizedBox(height: 50),
            //email title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: bigPadding),
              child: Text(
                'Adres e-mail',
                style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
              ),
            ),
            const SizedBox(height: 5),
            //user email
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: bigPadding),
              child: Text(
                user.email!,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: bigPadding),
              child: Divider(
                color: Colors.black,
                thickness: 1,
              ),
            ),
            const SizedBox(height: 20),
            //date title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: bigPadding),
              child: Text(
                'Data założenia',
                style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
              ),
            ),
            const SizedBox(height: 5),
            //user date
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: bigPadding),
              child: Row(
                children: [
                  Text(
                    user.metadata.creationTime!.year.toString(),
                    style: const TextStyle(fontSize: 16),
                  ),
                  const Text(
                    ' - ',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    user.metadata.creationTime!.month.toString(),
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: bigPadding),
              child: Divider(
                color: Colors.black,
                thickness: 1,
              ),
            ),
            const SizedBox(height: 30),
            //logout button
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                icon: const Icon(Icons.logout_rounded),
                label: const Text('WYLOGUJ'),
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
