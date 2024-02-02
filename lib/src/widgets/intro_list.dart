import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wik/src/firestore_interface.dart';
import 'package:wik/src/widgets/intro_to_post.dart';

class IntroList extends StatelessWidget {
  const IntroList({super.key});

  @override
  Widget build(BuildContext context) {
    final usersQuery = FirebaseFirestore.instance
        .collection('intros')
        .orderBy('createdAt', descending: true);

    return FirestoreListView(
      query: usersQuery,
      itemBuilder: (context, snapshot) {
        final introData = IntroData.fromFireStore(snapshot.data());
        return IntroToPost(data: introData, postRef: introData.postRef);
      },
    );
  }
}
