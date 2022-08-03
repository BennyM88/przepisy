// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:przepisy/extras/show_recipe_all_details.dart';
import 'package:przepisy/extras/show_image.dart';
import 'package:przepisy/widgets/snack_bar.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class RecipeDetails extends StatefulWidget {
  final String docID;

  RecipeDetails({required this.docID});

  @override
  State<RecipeDetails> createState() => _RecipeDetailsState();
}

class _RecipeDetailsState extends State<RecipeDetails> {
  final User? user = FirebaseAuth.instance.currentUser;

  //bool _isLiked = false;

  Future<dynamic> _addToFav(bool isLiked) async {
    isLiked = !isLiked;
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('users-favorite');
    if (isLiked) {
      return collectionRef
          .doc(user!.email)
          .collection('liked')
          .doc(widget.docID)
          .set({
        'dish name': ShowRecipeAllDetails.data['dish name'],
        'time': ShowRecipeAllDetails.data['time'],
        'url': ShowImage.data['url'],
      }).then((_) => SnackBarWidget.infoSnackBar(
              context, 'Dodano do ulubionych', Colors.grey.shade800));
    } else {
      return collectionRef
          .doc(user!.email)
          .collection('liked')
          .doc(widget.docID)
          .delete()
          .then((value) => SnackBarWidget.infoSnackBar(
              context, 'Usunieto z ulubionych', Colors.grey.shade800));
    }
  }

  /*Future<bool> checkIfLiked() async {
    try {
      DocumentSnapshot ds = await FirebaseFirestore.instance
          .collection('users-favorite')
          .doc(user!.email)
          .collection('liked')
          .doc(widget.docID)
          .get();
      setState(() {
        _isLiked = ds.exists;
      });
      return _isLiked;
    } catch (e) {
      return false;
    }
  }*/

  @override
  void initState() {
    //checkIfLiked();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
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
                  ? StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('users-favorite')
                          .doc(user!.email)
                          .collection('liked')
                          .doc(widget.docID)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Positioned(
                            top: 30,
                            right: 15,
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.favorite_outline),
                              color: Colors.white,
                              iconSize: 32,
                            ),
                          );
                        }
                        if (snapshot.data?.exists ?? false) {
                          return Positioned(
                            top: 30,
                            right: 15,
                            child: IconButton(
                              onPressed: () {
                                _addToFav(true);
                              },
                              icon: const Icon(Icons.favorite),
                              color: Colors.white,
                              iconSize: 32,
                            ),
                          );
                        } else {
                          return Positioned(
                            top: 30,
                            right: 15,
                            child: IconButton(
                              onPressed: () {
                                _addToFav(false);
                              },
                              icon: const Icon(Icons.favorite_outline),
                              color: Colors.white,
                              iconSize: 32,
                            ),
                          );
                        }
                        /*return Positioned(
                          top: 30,
                          right: 15,
                          child: IconButton(
                            onPressed: addToFav,
                            icon: (snapshot.data?.exists ?? false) && _isLiked
                                ? const Icon(Icons.favorite)
                                : const Icon(Icons.favorite_outline),
                            color: Colors.white,
                            iconSize: 32,
                          ),
                        );*/
                      },
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
        panel: ShowRecipeAllDetails(docID: widget.docID),
      ),
    );
  }
}
