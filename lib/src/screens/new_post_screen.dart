import 'package:flutter/material.dart';
import 'package:wik/src/widgets/new_post.dart';

class NewPostScreen extends StatelessWidget {
  const NewPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Share your experience!'),
      ),
      body: const NewPost(),
    );
  }
}
