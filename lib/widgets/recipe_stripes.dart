// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:przepisy/extras/show_image.dart';
import 'package:przepisy/extras/show_recipe_details.dart';
import 'package:przepisy/pages/recipe_details.dart';

class RecipeStripes extends StatefulWidget {
  const RecipeStripes({Key? key}) : super(key: key);

  @override
  State<RecipeStripes> createState() => _RecipeStripesState();
}

class _RecipeStripesState extends State<RecipeStripes> {
  List<String> docIDs = [];

  Future<void> _getID() async {
    await FirebaseFirestore.instance
        .collection('przepisy-details')
        .orderBy('time', descending: false)
        .limit(5)
        .get()
        .then(
          (snapshot) => snapshot.docs.forEach(
            (document) {
              docIDs.add(document.reference.id);
            },
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: FutureBuilder(
        future: _getID(),
        builder: (context, snapshot) {
          return ListView.builder(
            shrinkWrap: true,
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
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Stack(
                    children: [
                      ShowImage(
                          docID: docIDs[index],
                          width: size.width,
                          height: size.height * 0.12),
                      Positioned(
                          top: 10,
                          left: 10,
                          child: ShowRecipeDetails(
                            docID: docIDs[index],
                            isBlack: false,
                          )),
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
