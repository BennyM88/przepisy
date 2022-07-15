// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:przepisy/extras/get_przepisy_all_details.dart';
import 'package:przepisy/extras/show_image.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class RecipeDetails extends StatelessWidget {
  final String docID;

  RecipeDetails({required this.docID});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SlidingUpPanel(
        minHeight: (size.height / 2),
        maxHeight: (size.height / 1.2),
        parallaxEnabled: true,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              ShowImage(
                  docID: docID,
                  width: double.infinity,
                  height: (size.height / 2) + 50),
              Positioned(
                top: 40,
                right: 20,
                child: Icon(
                  Icons.favorite_outline,
                  color: Colors.white,
                  size: 32,
                ),
              ),
              Positioned(
                top: 40,
                left: 20,
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              ),
            ],
          ),
        ),
        panel: GetPrzepisyAllDetails(docID: docID),
      ),
    );
  }
}
