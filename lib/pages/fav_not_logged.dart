import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                children: [
                  TextSpan(
                      text: 'you_must'.tr,
                      style:
                          const TextStyle(fontSize: 18, color: Colors.black)),
                  TextSpan(
                    text: 'login'.tr,
                    style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
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
