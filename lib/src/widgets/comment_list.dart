import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wik/src/firestore_interface.dart';
import 'package:wik/src/globals.dart';
import 'package:wik/src/widgets/comment_card.dart';

class CommentList extends StatelessWidget {
  final DocumentReference postRef;
  const CommentList({super.key, required this.postRef});

  @override
  Widget build(BuildContext context) {
    final usersQuery = FirebaseFirestore.instance
        .collection('comments')
        .where('postRef', isEqualTo: postRef)
        .orderBy('createdAt', descending: true);

    return FirestoreListView(
      shrinkWrap: true,
      primary: false,
      query: usersQuery,
      itemBuilder: (context, snapshot) {
        final data = CommentData.fromFireStore(snapshot.data());
        return Column(
          children: [
            if (data.userRef == myRef)
              Row(
                children: [
                  IconButton(
                      onPressed: () => {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) =>
                            //             CommentEditScreen(data: snapshot.reference))),
                          },
                      icon: const Icon(Icons.edit))
                ],
              ),
            CommentCard(data: data.toRO())
          ],
        );
      },
    );
  }
}
