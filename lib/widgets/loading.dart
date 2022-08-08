import 'package:flutter/material.dart';
import 'package:przepisy/constants.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: secondaryColor,
      child: const Center(
        child: CircularProgressIndicator(color: primaryColor),
      ),
    );
  }
}
