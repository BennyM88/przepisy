// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class GetPrzepisyAllDetails extends StatelessWidget {
  final String docID;

  GetPrzepisyAllDetails({required this.docID});

  @override
  Widget build(BuildContext context) {
    CollectionReference przepisy =
        FirebaseFirestore.instance.collection('przepisy-details');
    return FutureBuilder<DocumentSnapshot>(
      future: przepisy.doc(docID).get(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          List<String> ingredients = List.from(data['ingredients']);
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
                SizedBox(height: 20),
                Text(
                  '${data['dish name']}',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.timer_outlined, size: 16),
                    SizedBox(width: 4),
                    Text(
                      '${data['time']} min',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Divider(color: Colors.black.withOpacity(0.5)),
                Expanded(
                  child: DefaultTabController(
                    length: 2,
                    initialIndex: 0,
                    child: Column(
                      children: [
                        TabBar(
                          tabs: [
                            Tab(text: 'Składniki'),
                            Tab(text: 'Przygotowanie'),
                          ],
                          indicator: DotIndicator(
                            color: Colors.black,
                            distanceFromCenter: 16,
                          ),
                          labelColor: Colors.black,
                          unselectedLabelColor: Colors.black.withOpacity(0.3),
                          labelPadding: EdgeInsets.symmetric(horizontal: 24.0),
                        ),
                        Expanded(
                          child: TabBarView(children: [
                            SingleChildScrollView(
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  itemCount: ingredients.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Text(
                                        '⚫ ${ingredients[index]}',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    );
                                  }),
                            ),
                            SingleChildScrollView(
                              child: Text(
                                '${data['description']}',
                                style: TextStyle(fontSize: 16),
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
        }
        return Center(child: CircularProgressIndicator());
      }),
    );
  }
}
