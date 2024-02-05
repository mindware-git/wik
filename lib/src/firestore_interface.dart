import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

/// Data interface with firebase firestore (cloud_firestore)

class UserData {
  final String userId;
  final String userName;
  final Timestamp createdAt;

  UserData(
      {required this.userId, required this.userName, required this.createdAt});
}

String convertDateString(Timestamp? time) {
  DateTime date = (time == null) ? DateTime.now() : time.toDate();
  return date.toString();
}

IconData? toIcon(int? score) {
  if (score == null) return null;
  assert(score < 5);
  switch (score) {
    case 0:
      return Icons.sentiment_very_dissatisfied;
    case 1:
      return Icons.sentiment_dissatisfied;
  }
  return Icons.sentiment_neutral;
}

/// Intro Read Only Data
class IntroROData {
  final String createdAt;
  final String userName;
  final String title;
  final String? bodyText;
  final String? thumbnailURL;
  final IconData? reviewIconData;

  IntroROData(
      {required this.createdAt,
      required this.userName,
      required this.title,
      required this.bodyText,
      required this.thumbnailURL,
      required this.reviewIconData});
}

class IntroData {
  final DocumentReference postRef;
  final Timestamp? createdAt;
  final String userName;
  final String title;
  final String? bodyText;
  final String? thumbnailURL;
  final int? reviewScore;

  IntroData(
      {required this.postRef,
      required this.createdAt,
      required this.userName,
      required this.title,
      required this.bodyText,
      required this.thumbnailURL,
      required this.reviewScore});

  IntroData.fromFireStore(Map firestore)
      : postRef = firestore['postRef'],
        createdAt = firestore['createdAt'],
        userName = firestore['userName'],
        title = firestore['title'],
        bodyText = firestore['bodyText'],
        thumbnailURL = firestore['thumbnailURL'],
        reviewScore = firestore['reviewScore'];

  IntroROData toRO() {
    IntroROData data = IntroROData(
        createdAt: convertDateString(createdAt),
        userName: userName,
        title: title,
        bodyText: bodyText,
        thumbnailURL: thumbnailURL,
        reviewIconData: toIcon(reviewScore));
    return data;
  }
}

class PostROData {
  final String createdAt;
  final String userName;
  final String title;
  final String? bodyText;
  final String? imgURL;
  final IconData? reviewIconData;
  final String? workField;
  final GeoPoint? location;

  PostROData(
      {required this.createdAt,
      required this.userName,
      required this.title,
      required this.bodyText,
      required this.imgURL,
      required this.reviewIconData,
      required this.workField,
      required this.location});
}

class PostData {
  final DocumentReference userRef;
  final Timestamp? createdAt;
  final String userName;
  final String title;
  final String? bodyText;
  final String? imgURL;
  final int? reviewScore;
  final String? workField;
  final GeoPoint? location;

  PostData(
      {required this.userRef,
      required this.createdAt,
      required this.userName,
      required this.title,
      required this.bodyText,
      required this.imgURL,
      required this.reviewScore,
      required this.workField,
      required this.location});

  PostData.fromFireStore(Map firestore)
      : userRef = firestore['userRef'],
        createdAt = firestore['createdAt'],
        userName = firestore['userName'],
        title = firestore['title'],
        bodyText = firestore['bodyText'],
        imgURL = firestore['imgURL'],
        reviewScore = firestore['reviewScore'],
        workField = firestore['workField'],
        location = firestore['location'];
  PostROData toRO() {
    PostROData data = PostROData(
        createdAt: convertDateString(createdAt),
        userName: userName,
        title: title,
        bodyText: bodyText,
        imgURL: imgURL,
        reviewIconData: toIcon(reviewScore),
        workField: workField,
        location: location);
    return data;
  }
}

class CommentROData {
  final String createdAt;
  final String userName;
  final String bodyText;

  CommentROData(
      {required this.createdAt,
      required this.userName,
      required this.bodyText});
}

class CommentData {
  final DocumentReference postRef;
  final DocumentReference userRef;
  final Timestamp? createdAt;
  final String userName;
  final String bodyText;

  CommentData(
      {required this.postRef,
      required this.userRef,
      required this.createdAt,
      required this.userName,
      required this.bodyText});

  CommentData.fromFireStore(Map firestore)
      : postRef = firestore['postRef'],
        userRef = firestore['userRef'],
        createdAt = firestore['createdAt'],
        userName = firestore['userName'],
        bodyText = firestore['bodyText'];

  CommentROData toRO() {
    CommentROData data = CommentROData(
        createdAt: convertDateString(createdAt),
        userName: userName,
        bodyText: bodyText);
    return data;
  }
}
