import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wik/src/globals.dart';

List<DropdownMenuItem> reviewItems = [
  const DropdownMenuItem(
    value: 1,
    child: Icon(Icons.sentiment_very_dissatisfied),
  ),
  const DropdownMenuItem(
    value: 2,
    child: Icon(Icons.sentiment_dissatisfied),
  ),
  const DropdownMenuItem(
    value: 3,
    child: Icon(Icons.sentiment_neutral),
  ),
  const DropdownMenuItem(
    value: 4,
    child: Icon(Icons.sentiment_satisfied),
  ),
  const DropdownMenuItem(
    value: 5,
    child: Icon(Icons.sentiment_very_satisfied),
  ),
];

List<DropdownMenuItem> workFieldItems = [
  const DropdownMenuItem(
    value: 'Manufacturing',
    child: Text('Manufacturing'),
  ),
  const DropdownMenuItem(
    value: 'Construction',
    child: Text('Construction'),
  ),
  const DropdownMenuItem(
    value: 'Service',
    child: Text('Service'),
  ),
  const DropdownMenuItem(
    value: 'Agriculture',
    child: Text('Agriculture'),
  ),
  const DropdownMenuItem(
    value: 'Others',
    child: Text('Others'),
  ),
];

class NewPost extends StatefulWidget {
  const NewPost({super.key});

  @override
  State<NewPost> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  String? _title;
  String? _bodyText;
  int? _reviewScore;
  String? _workField;
  bool _isLoading = false;
  bool _showReviewForm = false;
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
      debugPrint(_reviewScore.toString());
      await Future.delayed(const Duration(seconds: 2));
    } else {
      final postRef = await FirebaseFirestore.instance.collection('posts').add({
        'userRef': myRef!,
        'createdAt': FieldValue.serverTimestamp(),
        'userName': myName!,
        'title': _title!,
        'bodyText': _bodyText,
        'reviewScore': _reviewScore,
        'workField': _workField,
      });
      String? introBodyText;
      if (_bodyText != null) {
        introBodyText = _bodyText!.replaceAll('\n', ' ');
        if (introBodyText.length > 10) {
          introBodyText = introBodyText.substring(0, 10);
        }
      }
      await FirebaseFirestore.instance.collection('intros').add({
        'postRef': postRef,
        'createdAt': FieldValue.serverTimestamp(),
        'userName': myName!,
        'title': _title!,
        'bodyText': introBodyText,
        'reviewScore': _reviewScore,
      });
    }
    if (mounted) Navigator.pop(context);
  }

  void _toggleReview() async {
    setState(() {
      _showReviewForm = !_showReviewForm;
    });
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
                  ),
                  if (_showReviewForm)
                    DropdownButtonFormField(
                      hint: const Text('review score'),
                      items: reviewItems,
                      onChanged: (_) {},
                      onSaved: (newValue) => _reviewScore = newValue,
                      validator: (value) {
                        if (_showReviewForm) {
                          if (value == null) {
                            return 'Fill this form';
                          }
                        }
                        return null;
                      },
                    ),
                  if (_showReviewForm)
                    DropdownButtonFormField(
                      hint: const Text('working field'),
                      items: workFieldItems,
                      onChanged: (_) {},
                      onSaved: (newValue) => _workField = newValue,
                      validator: (value) {
                        if (_showReviewForm) {
                          if (value == null) {
                            return 'Fill this form';
                          }
                        }
                        return null;
                      },
                    )
                ],
              )),
          IconButton(
            onPressed: () => _toggleReview(),
            icon: const Icon(Icons.rate_review),
          ),
        ]))),
      ],
    );
  }
}
