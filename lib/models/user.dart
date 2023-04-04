import 'dart:convert';

import 'package:amaze/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User extends ChangeNotifier {
  // final String role;

  final String? id;
  String? first_name;
  final String? last_name;
  final String? middle_name;
  final String? email;
  final String? about_author;
  final String? phone;
  final String? city;
  final String? country;
  final String? dateOB;
  final String? profilePicture;
  final String? password;
  final List? followers;
  String? token;

  User({
    this.id,
    this.first_name,
    this.last_name,
    this.middle_name,
    this.about_author,
    this.email,
    this.phone,
    this.city,
    this.country,
    this.dateOB,
    this.profilePicture,
    this.password,
    this.followers,
    this.token,
  });

  static User fromJson(Map<String, dynamic> json) => User(
        id: json['_id'],
        first_name: json['first_name'],
        last_name: json['last_name'],
        middle_name: json['middle_name'],
        about_author: json['about_author'],
        city: json['city'],
        country: json['country'],
        dateOB: json['last_name'],
        profilePicture: json['profilePicture'],
        email: json['email'],
        phone: json['phone'],
        token: json['token'],
        followers: json['followers'],
      );
  Map<String, Object?> toJson() => {
        // 'id': id,
        'first_name': first_name,
        'last_name': last_name,
        'email': email,
        'profilePicture': profilePicture,
        'password': password,
      };
}
