import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  String name;
  String email;
  String uId;
  String password;

  UserModel({
    required this.name,
    required this.email,
    required this.uId,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'uId': uId,
      'password': password,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      email: map['email'] as String,
      uId: map['uId'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  static UserModel? fromFirebaseUser(User user) {}

  UserModel copyWith({
    String? name,
    String? email,
    String? uId,
    String? password,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      uId: uId ?? this.uId,
      password: password ?? this.password,
    );
  }

  @override
  String toString() {
    return 'UserModel(name: $name, email: $email, uId: $uId, password: $password)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.email == email &&
        other.uId == uId &&
        other.password == password;
  }

  @override
  int get hasCode => name.hashCode ^ email.hashCode ^ uId.hashCode;

  @override
  int get hashCode {
    return name.hashCode ^ email.hashCode ^ uId.hashCode ^ password.hashCode;
  }
}
