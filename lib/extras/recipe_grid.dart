// ignore_for_file: prefer_const_constructors, avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:przepisy/extras/show_image.dart';
import 'package:przepisy/pages/recipe_details.dart';

import 'get_recipe_details.dart';

class RecipeGrid extends StatefulWidget {
  const RecipeGrid({Key? key}) : super(key: key);

  @override
  State<RecipeGrid> createState() => _RecipeGridState();
}

class _RecipeGridState extends State<RecipeGrid> {
  List<String> docIDs = [];

  Future<void> getID() async {
    await FirebaseFirestore.instance.collection('przepisy-details').get().then(
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
    final double itemHeight = (size.height - kToolbarHeight - 96) / 2;
    final double itemWidth = size.width / 2;
    return Scaffold(
      body: FutureBuilder(
        future: getID(),
        builder: (context, snapshot) {
          return GridView.builder(
            itemCount: docIDs.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: itemWidth / itemHeight),
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
                  padding: const EdgeInsets.all(10.0),
                  child: Stack(
                    children: [
                      Container(
                        height: size.height * 0.35,
                        width: size.width / 2,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade500,
                              offset: Offset(1, 2),
                              blurRadius: 8,
                              spreadRadius: 0.5,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4),
                        child: ShowImage(
                            docID: docIDs[index],
                            width: size.width / 2,
                            height: size.height * 0.26),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Icon(
                          Icons.favorite_outline,
                          color: Colors.white,
                        ),
                      ),
                      Positioned(
                        bottom: itemHeight / 14,
                        left: 10,
                        child: GetRecipeDetails(docID: docIDs[index]),
                      ),
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
