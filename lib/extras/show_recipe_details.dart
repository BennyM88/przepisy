// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShowRecipeDetails extends StatelessWidget {
  final String docID;
  final bool isBlack;

  ShowRecipeDetails({required this.docID, required this.isBlack});

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${data['dish name']}',
                style: isBlack
                    ? const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                    : const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
              ),
              Row(
                children: [
                  Icon(
                    Icons.timer_outlined,
                    size: 16,
                    color: isBlack ? Colors.black : Colors.white,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${data['time']} min',
                    style: isBlack
                        ? const TextStyle(fontSize: 14)
                        : const TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
            ],
          );
        }
        return const Text('');
      }),
    );
  }
}
