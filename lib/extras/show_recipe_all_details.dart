// ignore_for_file: use_key_in_widget_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:przepisy/constants.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class ShowRecipeAllDetails extends StatelessWidget {
  final String docID;
  static Map<String, dynamic> data = {};

  const ShowRecipeAllDetails({required this.docID});

  @override
  Widget build(BuildContext context) {
    CollectionReference recipe =
        FirebaseFirestore.instance.collection('przepisy-details');
    return FutureBuilder<DocumentSnapshot>(
      future: recipe.doc(docID).get(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            data = snapshot.data!.data() as Map<String, dynamic>;
            List<String> ingredients = List.from(data['ingredients']);
            String servings = Get.locale == const Locale('pl', 'PL')
                ? (data['amount'] < 5 ? 'porcje' : 'porcji')
                : 'servings';
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      height: 5,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '${data['dish name']}',
                    style: const TextStyle(
                        fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.timer_outlined, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        '${data['time']} min',
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(width: 4),
                      const Text('|'),
                      const SizedBox(width: 4),
                      Text(
                        '${data['amount']} $servings',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Divider(
                    color: primaryColor.withOpacity(0.5),
                  ),
                  Expanded(
                    child: DefaultTabController(
                      length: 2,
                      initialIndex: 0,
                      child: Column(
                        children: [
                          TabBar(
                            tabs: [
                              Tab(text: 'ingredients'.tr),
                              Tab(text: 'preparation'.tr),
                            ],
                            indicator: DotIndicator(
                              color: primaryColor,
                              distanceFromCenter: 16,
                            ),
                            labelColor: primaryColor,
                            unselectedLabelColor: primaryColor.withOpacity(0.3),
                            labelPadding:
                                const EdgeInsets.symmetric(horizontal: 24.0),
                          ),
                          Expanded(
                            child: TabBarView(children: [
                              SingleChildScrollView(
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: const ScrollPhysics(),
                                    itemCount: ingredients.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: Text(
                                          '⚫ ${ingredients[index]}',
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      );
                                    }),
                              ),
                              SingleChildScrollView(
                                child: Text(
                                  '${data['description']}'
                                      .replaceAll('\\n', '\n'),
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ]),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Icon(Icons.error),
            );
          }
        }
        return const Center(
          child: CircularProgressIndicator(color: primaryColor),
        );
      }),
    );
  }
}
