// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:aissam_store/data/model/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? userId;
  String? email;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? profilePhotoUrl;

  UserModel({
    this.userId,
    this.email,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.profilePhotoUrl,
  }) {
    if (firstName != null && firstName!.isEmpty) firstName = null;
    if (lastName != null && lastName!.isEmpty) lastName = null;
    if (phoneNumber != null && phoneNumber!.isEmpty) phoneNumber = null;
    if (profilePhotoUrl != null && profilePhotoUrl!.isEmpty)
      profilePhotoUrl = null;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user_id': userId,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'phone_number': phoneNumber,
      'profile_photo_url': profilePhotoUrl,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['user_id'],
      email: map['email'],
      firstName: map['first_name'],
      lastName: map['last_name'],
      phoneNumber: map['phone_number'],
      profilePhotoUrl: map['profile_photo_url'],
    );
  }

  factory UserModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data()!;
    return UserModel(
      userId: data['user_id'],
      email: data['email'],
      firstName: data['first_name'],
      lastName: data['last_name'],
      phoneNumber: data['phone_number'],
      profilePhotoUrl: data['profile_photo_url'],
    );
  }
}
