import 'package:flutter/cupertino.dart';

class User {
  final String name;
  final String designation;
  final int mutualFriends;
  final int miles;
  final int age;
  final String imgUrl;
  final String gender;
  final String bio;
  final List<String> likes;

  bool isLiked;
  bool isSwipedOff;

  User({
    required this.designation,
    required this.mutualFriends,
    required this.name,
    required this.age,
    required this.imgUrl,
    required this.likes,
    required this.gender,
    required this.miles,
    required this.bio,
    this.isLiked = false,
    this.isSwipedOff = false,
  });
}
