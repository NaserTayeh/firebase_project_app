// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String fullName;
  String emailAddress;
  String password;
  String? userId;
  UserModel({
    required this.fullName,
    required this.emailAddress,
    required this.password,
    this.userId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fullName': fullName,
      'emailAddress': emailAddress,
      'password': password,
    };
  }

  factory UserModel.fromMap(map) {
    return UserModel(
      fullName: map['fullName'] as String,
      emailAddress: map['emailAddress'] as String,
      password: map['password'] as String,
    );
  }
}
