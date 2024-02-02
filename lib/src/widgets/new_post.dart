import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wik/src/globals.dart';

class NewPost extends StatefulWidget {
  const NewPost({super.key});

  @override
  State<NewPost> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  String? _title;
  String? _bodyText;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  void _save() async {
    if (_isLoading) return;

    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() {
      _isLoading = true;
    });
    _formKey.currentState!.save();

    if (kDebugMode) {
      await Future.delayed(const Duration(seconds: 2));
    } else {
      final postRef = await FirebaseFirestore.instance.collection('posts').add({
        'userRef': myRef!,
        'createdAt': FieldValue.serverTimestamp(),
        'userName': myName!,
        'title': _title!,
        'bodyText': _bodyText,
      });
      await FirebaseFirestore.instance.collection('intros').add({
        'postRef': postRef,
        'createdAt': FieldValue.serverTimestamp(),
        'userName': myName!,
        'title': _title!,
        'bodyText': _bodyText,
      });
    }
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return const CircularProgressIndicator();
    return Column(
      children: [
        IconButton(onPressed: _save, icon: const Icon(Icons.send)),
        Expanded(
            child: SingleChildScrollView(
                child: Column(children: [
          Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Title'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Title cannot be empty';
                      }
                      return null;
                    },
                    onSaved: (newValue) => _title = newValue,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 100,
                    decoration: const InputDecoration(labelText: 'Body'),
                    onSaved: (newValue) => _bodyText = newValue,
                  )
                ],
              )),
        ]))),
      ],
    );
  }
}
