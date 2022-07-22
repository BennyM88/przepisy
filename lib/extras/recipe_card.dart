// ignore_for_file: avoid_function_literals_in_foreach_calls, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:przepisy/extras/get_recipe_details.dart';
import 'package:przepisy/extras/show_image.dart';
import 'package:przepisy/pages/recipe_details.dart';

class RecipeCard extends StatefulWidget {
  RecipeCard({
    Key? key,
    required this.category,
  }) : super(key: key);

  final String category;

  @override
  State<RecipeCard> createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  List<String> docIDs = [];

  Future getID() async {
    if (widget.category == 'w') {
      await FirebaseFirestore.instance
          .collection('przepisy-details')
          .get()
          .then(
            (snapshot) => snapshot.docs.forEach(
              (document) {
                docIDs.add(document.reference.id);
              },
            ),
          );
    } else {
      await FirebaseFirestore.instance
          .collection('przepisy-details')
          .where('category', isEqualTo: widget.category)
          .get()
          .then(
            (snapshot) => snapshot.docs.forEach(
              (document) {
                docIDs.add(document.reference.id);
              },
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getID(),
        builder: (context, snapshot) {
          return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: docIDs.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              RecipeDetails(docID: docIDs[index])));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          ShowImage(
                              docID: docIDs[index], width: 200, height: 180),
                          Positioned(
                            top: 10,
                            right: 10,
                            child: Icon(
                              Icons.favorite_outline,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      GetRecipeDetails(docID: docIDs[index]),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
