import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wik/src/firestore_interface.dart';
import 'package:wik/src/widgets/intro_to_post.dart';

class Rank extends StatefulWidget {
  const Rank({super.key});

  @override
  State<Rank> createState() => _RankState();
}

class _RankState extends State<Rank> {
  final TextEditingController fieldController = TextEditingController();
  String? selectedField;

  @override
  Widget build(BuildContext context) {
    final usersQuery = FirebaseFirestore.instance
        .collection('intros')
        .orderBy('createdAt', descending: true);
    return SingleChildScrollView(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownMenu(
                controller: fieldController,
                label: const Text('Field'),
                onSelected: (String? field) {
                  setState(() {
                    selectedField = field;
                  });
                },
                dropdownMenuEntries: workFields
                    .map((e) => DropdownMenuEntry(value: e, label: e))
                    .toList(),
              ),
            ],
          ),
        ),
        if (selectedField != null)
          Column(
            children: [
              Text('You selected a $selectedField'),
              const Text('Average score: 4.5 out of 5'),
              FirestoreListView(
                shrinkWrap: true,
                primary: false,
                query: usersQuery,
                itemBuilder: (context, snapshot) {
                  final introData = IntroData.fromFireStore(snapshot.data());
                  return IntroToPost(
                      data: introData, postRef: introData.postRef);
                },
              ),
            ],
          )
        else
          const Text('Please select a color and an icon.')
      ],
    ));
  }
}
