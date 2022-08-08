// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:przepisy/extras/show_image.dart';
import 'package:przepisy/extras/show_recipe_details.dart';
import 'package:przepisy/pages/details/recipe_details.dart';

class RecipeStripes extends StatefulWidget {
  const RecipeStripes({Key? key}) : super(key: key);

  @override
  State<RecipeStripes> createState() => _RecipeStripesState();
}

class _RecipeStripesState extends State<RecipeStripes> {
  late Future<void> _dataFuture;
  final List<String> _docIDs = [];

  @override
  void initState() {
    super.initState();
    _dataFuture = _getID();
  }

  Future<void> _getID() async {
    await FirebaseFirestore.instance
        .collection('przepisy-details')
        .orderBy('time', descending: false)
        .limit(5)
        .get()
        .then(
          (snapshot) => snapshot.docs.forEach(
            (document) {
              _docIDs.add(document.reference.id);
            },
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: FutureBuilder(
        future: _dataFuture,
        builder: (context, snapshot) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: _docIDs.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              RecipeDetails(docID: _docIDs[index])));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Stack(
                    children: [
                      ShowImage(
                          docID: _docIDs[index],
                          width: size.width,
                          height: size.height * 0.12),
                      Positioned(
                        top: 10,
                        left: 10,
                        child: ShowRecipeDetails(
                          docID: _docIDs[index],
                          isBlack: false,
                        ),
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
