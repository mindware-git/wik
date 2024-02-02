import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wik/src/firestore_interface.dart';
import 'package:wik/src/globals.dart';
import 'package:wik/src/widgets/comment_list.dart';
import 'package:wik/src/widgets/new_comment.dart';
import 'package:wik/src/widgets/post_card.dart';

class PostWithCommentScreen extends StatelessWidget {
  final DocumentReference postRef;
  const PostWithCommentScreen({super.key, required this.postRef});

  @override
  Widget build(BuildContext context) {
    final usersQuery = postRef.get();
    return Scaffold(
        appBar: AppBar(title: const Text('Post')),
        body: FutureBuilder(
            future: usersQuery,
            builder: (BuildContext context, snapshot) {
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else if (!snapshot.hasData) {
                return const Text('Wait for connection');
              } else if (snapshot.connectionState == ConnectionState.done) {
                final firebaseData = snapshot.data!.data();
                final postData = PostData.fromFireStore(firebaseData as Map);
                final postROData = postData.toRO();
                return SingleChildScrollView(
                    child: Column(children: [
                  if (postData.userRef == myRef!)
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
                  PostCard(data: postROData),
                  NewComment(postRef: postRef),
                  CommentList(postRef: postRef),
                ]));
              }
              return const CircularProgressIndicator();
            }));
  }
}
