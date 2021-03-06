// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShowImage extends StatelessWidget {
  final String docID;
  final double width;
  final double height;

  ShowImage({required this.docID, required this.width, required this.height});

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
          return Align(
            alignment: AlignmentDirectional.topCenter,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: CachedNetworkImage(
                imageUrl: data['url'],
                width: width,
                height: height,
                fit: BoxFit.cover,
                placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(color: Colors.black)),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          );
        }
        return SizedBox(
            width: 200,
            height: 180,
            child:
                Center(child: CircularProgressIndicator(color: Colors.black)));
      }),
    );
  }
}
