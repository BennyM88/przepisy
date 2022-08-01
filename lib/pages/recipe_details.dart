// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:przepisy/extras/show_recipe_all_details.dart';
import 'package:przepisy/extras/show_image.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class RecipeDetails extends StatefulWidget {
  final String docID;

  RecipeDetails({required this.docID});

  @override
  State<RecipeDetails> createState() => _RecipeDetailsState();
}

class _RecipeDetailsState extends State<RecipeDetails> {
  final user = FirebaseAuth.instance.currentUser;

  bool isLiked = false;

  Future addToFav() async {
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('users-favorite');
    return collectionRef
        .doc(user!.email)
        .collection('liked')
        .doc(widget.docID)
        .set({
      'dish name': ShowRecipeAllDetails.data['dish name'],
      'time': ShowRecipeAllDetails.data['time'],
      'url': ShowImage.data['url'],
    }).then((value) => print('added'));
  }

  Future<bool> checkIfLiked() async {
    try {
      DocumentSnapshot ds = await FirebaseFirestore.instance
          .collection('users-favorite')
          .doc(user!.email)
          .collection('liked')
          .doc(widget.docID)
          .get();
      setState(() {
        isLiked = ds.exists;
      });
      return isLiked;
    } catch (e) {
      return false;
    }
  }

  @override
  void initState() {
    checkIfLiked();
    super.initState();
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
                  docID: widget.docID,
                  width: double.infinity,
                  height: (size.height / 2) + 50),
              user != null
                  ? StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('users-favorite')
                          .doc(user!.email)
                          .collection('liked')
                          .where('dish name',
                              isEqualTo: ShowRecipeAllDetails.data['dish name'])
                          .snapshots(),
                      builder: (context, snapshot) {
                        return Positioned(
                          top: 30,
                          right: 15,
                          child: IconButton(
                            onPressed: addToFav,
                            icon: isLiked
                                ? const Icon(Icons.favorite)
                                : const Icon(Icons.favorite_outline),
                            color: Colors.white,
                            iconSize: 32,
                          ),
                        );
                      })
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
        panel: ShowRecipeAllDetails(docID: widget.docID),
      ),
    );
  }
}
