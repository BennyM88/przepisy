import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:przepisy/constants.dart';

class FavoriteNotLogged extends StatelessWidget {
  const FavoriteNotLogged({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.warning_amber_rounded,
              size: 120,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 20),
            RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 18, color: primaryColor),
                children: [
                  TextSpan(
                    text: 'you_must'.tr,
                  ),
                  TextSpan(
                    text: 'login'.tr,
                    style: const TextStyle(fontWeight: FontWeight.bold),
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
