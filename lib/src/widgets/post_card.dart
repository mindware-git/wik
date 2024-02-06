import 'package:flutter/material.dart';
import 'package:wik/src/firestore_interface.dart';

class PostCard extends StatelessWidget {
  final PostROData data;

  const PostCard({super.key, required this.data});

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
      Text(data.title),
      const SizedBox(height: 8.0),
      if (data.bodyText != null)
        Column(
          children: [
            Text(data.bodyText!),
            const SizedBox(height: 8.0),
          ],
        ),
      if (data.reviewIconData != null)
        Column(
          children: [
            Icon(data.reviewIconData),
            const SizedBox(height: 8.0),
            Text(data.workField!),
            const SizedBox(height: 8.0),
          ],
        ),
      // very long long test
    ]));
  }
}
