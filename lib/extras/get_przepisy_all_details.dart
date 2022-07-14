// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
          return Column(
            children: [
              Text(
                '${data['dish name']}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
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
            ],
          );
        }
        return Center(child: CircularProgressIndicator());
      }),
    );
  }
}
