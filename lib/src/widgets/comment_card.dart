import 'package:flutter/material.dart';
import 'package:wik/src/firestore_interface.dart';

class CommentCard extends StatelessWidget {
  final CommentROData data;

  const CommentCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(children: [
      Row(
        children: [
          Text(data.userName),
          const SizedBox(width: 8.0),
          Text(data.createdAt),
        ],
      ),
      const SizedBox(height: 8.0),
      Column(
        children: [
          Text(data.bodyText),
        ],
      ),
    ]));
  }
}
