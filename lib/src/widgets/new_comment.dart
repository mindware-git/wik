import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wik/src/globals.dart';

class NewComment extends StatefulWidget {
  final DocumentReference postRef;
  const NewComment({super.key, required this.postRef});

  @override
  State<NewComment> createState() => _NewCommentState();
}

class _NewCommentState extends State<NewComment> {
  bool _isLoading = false;
  final _controller = TextEditingController();

  void _save() async {
    if (_controller.text.isEmpty) return;
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    if (kDebugMode) {
      await Future.delayed(const Duration(seconds: 2));
    } else {
      await FirebaseFirestore.instance.collection('comments').add({
        'postRef': widget.postRef,
        'userRef': myRef!,
        'createdAt': FieldValue.serverTimestamp(),
        'userName': myName!,
        'bodyText': _controller.text,
      });
      setState(() {
        _isLoading = false;
      });
    }
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return const CircularProgressIndicator();
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            decoration: const InputDecoration(labelText: 'leave comment'),
          ),
        ),
        IconButton(onPressed: _save, icon: const Icon(Icons.send)),
      ],
    );
  }
}
