import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

@immutable
class FShare {
  final String picture;
  final bool public;
  final DateTime uploadedAt;
  final int likes;
  final String title;
  final String user;

  const FShare({
    required this.picture,
    required this.public,
    required this.uploadedAt,
    required this.likes,
    required this.title,
    required this.user,
  });

  FShare.fromJson(Map<String, Object?> json)
      : this(
          picture: json["picture"]! as String,
          public: json["public"]! as bool,
          uploadedAt: (json["uploadedAt"]! as Timestamp).toDate(),
          likes: json["likes"]! as int,
          title: json["title"]! as String,
          user: json["user"]! as String,
        );

  Map<String, Object?> toJson() {
    return {
      "picture": picture,
      "public": public,
      "uploadedAt": Timestamp.fromDate(uploadedAt),
      "likes": likes,
      "title": title,
      "user": user,
    };
  }
}
