// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:przepisy/constants.dart';
import 'package:przepisy/extras/show_recipe_details.dart';
import 'package:przepisy/extras/show_image.dart';
import 'package:przepisy/pages/recipe_details.dart';
import '../extras/show_recipe_details.dart';

class RecipeGrid extends StatefulWidget {
  const RecipeGrid({Key? key}) : super(key: key);

  @override
  State<RecipeGrid> createState() => _RecipeGridState();
}

class _RecipeGridState extends State<RecipeGrid> {
  late Future<void> dataFuture;
  List<String> docIDs = [];
  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    dataFuture = _getID();
  }

  Future<void> _getID() async {
    await FirebaseFirestore.instance
        .collection('users-favorite')
        .doc(user!.email)
        .collection('liked')
        .get()
        .then(
          (snapshot) => snapshot.docs.forEach(
            (document) {
              docIDs.add(document.reference.id);
            },
          ),
        );
  }

  Future<void> deleteRecipe(id) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('delete_recipe'.tr),
          content: Text('are_u_sure_recipe'.tr),
          actions: [
            MaterialButton(
              onPressed: () {
                FirebaseFirestore.instance
                    .collection('users-favorite')
                    .doc(user!.email)
                    .collection('liked')
                    .doc(id)
                    .delete();
                Navigator.pop(context);
              },
              child: Text(
                'yes_delete_recipe'.tr,
                style: const TextStyle(color: Colors.red),
              ),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('cancel'.tr),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 96) / 2;
    final double itemWidth = size.width / 2;
    return Scaffold(
      body: FutureBuilder(
        future: dataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
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
                    padding: const EdgeInsets.all(smallPadding / 2),
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
                                offset: const Offset(1, 2),
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
                          top: 5,
                          right: 5,
                          child: IconButton(
                            onPressed: () {
                              deleteRecipe(docIDs[index]);
                            },
                            icon: const Icon(Icons.favorite),
                            color: Colors.white,
                          ),
                        ),
                        Positioned(
                          bottom: itemHeight / 14,
                          left: 10,
                          child: ShowRecipeDetails(
                            docID: docIDs[index],
                            isBlack: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
