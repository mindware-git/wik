import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wik/src/firestore_interface.dart';
import 'package:wik/src/screens/post_with_comment_screen.dart';
import 'package:wik/src/widgets/intro_card.dart';

class IntroToPost extends StatelessWidget {
  final IntroData data;
  final DocumentReference postRef;
  const IntroToPost({super.key, required this.data, required this.postRef});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PostWithCommentScreen(postRef: postRef)),
        );
      },
      child: IntroCard(data: data.toRO()),
    );
  }
}
