// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:przepisy/extras/show_recipe_all_details.dart';
import 'package:przepisy/extras/show_image.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class RecipeDetails extends StatelessWidget {
  final String docID;
  final user = FirebaseAuth.instance.currentUser;

  RecipeDetails({required this.docID});

  Future addToFav() async {
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('users-favorite');
    return collectionRef.doc(user!.email).collection('liked').doc(docID).set({
      'dish name': ShowRecipeAllDetails.data['dish name'],
      'time': ShowRecipeAllDetails.data['time'],
      'url': ShowImage.data['url'],
    }).then((value) => print('added'));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SlidingUpPanel(
        minHeight: (size.height / 2),
        maxHeight: (size.height / 1.2),
        parallaxEnabled: true,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        //image
        body: SingleChildScrollView(
          child: Stack(
            children: [
              ShowImage(
                  docID: docID,
                  width: double.infinity,
                  height: (size.height / 2) + 50),
              user != null
                  ? Positioned(
                      top: 30,
                      right: 15,
                      child: IconButton(
                        onPressed: addToFav,
                        icon: const Icon(Icons.favorite_outline),
                        color: Colors.white,
                        iconSize: 32,
                      ),
                    )
                  : const Text(''),
              Positioned(
                top: 40,
                left: 20,
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              ),
            ],
          ),
        ),
        //description
        panel: ShowRecipeAllDetails(docID: docID),
      ),
    );
  }
}
