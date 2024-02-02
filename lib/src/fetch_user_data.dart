import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wik/src/generate_user_data.dart';
import 'package:wik/src/globals.dart';
import 'package:wik/src/screens/root_screen.dart';

class FetchUserData extends StatelessWidget {
  final String uid;
  const FetchUserData({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    final usersQuery = FirebaseFirestore.instance
        .collection('users')
        .where('userId', isEqualTo: uid)
        .get();

    return FutureBuilder(
        future: usersQuery,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else if (!snapshot.hasData) {
            return const Text('Wait for connection');
          } else if (snapshot.connectionState == ConnectionState.done) {
            final docs = snapshot.data!.docs;
            assert(docs.length < 2);
            if (docs.isEmpty) return GenerateUserData(uid: uid);
            final doc = docs.first;
            myRef = doc.reference;
            myName = doc.data()['userName'];
            return const RootScreen();
          }
          return const CircularProgressIndicator();
        });
  }
}
