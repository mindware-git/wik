import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wik/src/globals.dart';
import 'package:wik/src/screens/root_screen.dart';

class GenerateUserData extends StatelessWidget {
  final String uid;
  const GenerateUserData({super.key, required this.uid});

  String generateRandomString(int len) {
    var r = Random();
    const chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => chars[r.nextInt(chars.length)]).join();
  }

  @override
  Widget build(BuildContext context) {
    myName = 'user${generateRandomString(6)}';
    final usersQuery = FirebaseFirestore.instance.collection('users').add({
      'userId': uid,
      'userName': myName,
      'createdAt': FieldValue.serverTimestamp(),
    });

    return FutureBuilder(
        future: usersQuery,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else if (!snapshot.hasData) {
            return const Text('Wait for connection');
          } else if (snapshot.connectionState == ConnectionState.done) {
            return const RootScreen();
          }
          return const CircularProgressIndicator();
        });
  }
}
