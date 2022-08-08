import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget saveFirstRecipe(double width, double height) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/recipe.jpg', width: width, height: height),
        Text(
          'save_your_first_recipe'.tr,
          style: const TextStyle(fontSize: 24),
        ),
      ],
    ),
  );
}
