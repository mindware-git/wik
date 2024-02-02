import 'package:flutter/material.dart';
import 'package:wik/src/firestore_interface.dart';

class IntroCard extends StatelessWidget {
  final IntroROData data;
  const IntroCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(children: [
        ListTile(
          title: Text(data.title),
          // subtitle: Text(data.bodyText),
          //imoji,
        ),
        //image
      ]),
    );
  }
}
