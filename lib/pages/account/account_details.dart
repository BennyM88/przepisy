import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:przepisy/constants.dart';
import 'package:przepisy/pages/account/about_version.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../extras/country.dart';
import '../../transitions/enter_exit_route.dart';
import '../../widgets/snack_bar.dart';
import 'account.dart';

class AccountDetails extends StatefulWidget {
  const AccountDetails({Key? key}) : super(key: key);

  @override
  State<AccountDetails> createState() => _AccountDetailsState();
}

class _AccountDetailsState extends State<AccountDetails> {
  final User user = FirebaseAuth.instance.currentUser!;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final Uri _mail = Uri(
      scheme: 'mailto',
      path: 'sosodexx@gmail.com', //CHANGE EMAIL!!!!
      query: 'subject=Support&body=How can we help you?');

  void _changeLanguage(Country country) {
    var localeUS = const Locale('en', 'US');
    var localePL = const Locale('pl', 'PL');
    if (country.countryCode == 'US') {
      Get.updateLocale(localeUS);
    } else if (country.countryCode == 'PL') {
      Get.updateLocale(localePL);
    }
  }

  void _launchUrl(Uri uri) async {
    if (!await launchUrl(uri)) throw 'Could not launch $uri';
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    await googleSignIn.signOut();
  }

  Future<void> _deleteAcc() async {
    var collection = FirebaseFirestore.instance
        .collection('users-favorite')
        .doc(user.email)
        .collection('liked');
    var snapshots = await collection.get();
    for (var doc in snapshots.docs) {
      await doc.reference.delete();
    }

    await user.delete().whenComplete(
          () => SnackBarWidget.infoSnackBar(
              context, 'acc_deleted'.tr, Colors.grey.shade800),
        );
    await googleSignIn.signOut();
  }

  Future<void> _deleteAccDialog() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('delete'.tr),
          content: Text('are_u_sure'.tr),
          actions: [
            MaterialButton(
              onPressed: () {
                _deleteAcc();
                Navigator.pop(context);
              },
              child: Text(
                'yes_delete'.tr,
                style: const TextStyle(color: Colors.red),
              ),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('cancel'.tr),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton(
              icon: const Icon(
                Icons.language,
                color: primaryColor,
              ),
              underline: const SizedBox(),
              items: Country.languageList()
                  .map<DropdownMenuItem<Country>>(
                    (lang) => DropdownMenuItem(
                      value: lang,
                      child: Row(
                        children: [
                          Text(lang.flag),
                          Text(lang.name),
                        ],
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (Country? country) {
                _changeLanguage(country!);
              },
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //icon
            const Center(
                child: Icon(
              Icons.person_outline_rounded,
              size: 100,
              color: primaryColor,
            )),
            const SizedBox(height: 50),
            //email title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: bigPadding),
              child: Text(
                'email_address'.tr,
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
                color: primaryColor,
                thickness: 1,
              ),
            ),
            const SizedBox(height: 20),
            //date title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: bigPadding),
              child: Text(
                'creation_date'.tr,
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
                color: primaryColor,
                thickness: 1,
              ),
            ),
            const SizedBox(height: 30),
            //extra activities
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: bigPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //version
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          EnterExitRoute(
                              exitPage: const Account(),
                              enterPage: const AboutVersion()));
                    },
                    child: Text(
                      'version'.tr,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                  const SizedBox(height: 20),
                  //contact via mail
                  GestureDetector(
                    onTap: () => _launchUrl(_mail),
                    child: Text(
                      'contact'.tr,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                  const SizedBox(height: 20),
                  //sign out
                  GestureDetector(
                    onTap: _signOut,
                    child: Text(
                      'logout'.tr,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                  const SizedBox(height: 20),
                  //delete acc
                  GestureDetector(
                    onTap: _deleteAccDialog,
                    child: Text(
                      'delete'.tr,
                      style: const TextStyle(fontSize: 18, color: Colors.red),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
