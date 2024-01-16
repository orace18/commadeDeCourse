import 'dart:convert';

class UserInfo {
  final int id;
  final String username;
  final String name;
  final String lastName;
  // Ajoutez d'autres propriétés au besoin

  UserInfo({
    required this.id,
    required this.username,
    required this.name,
    required this.lastName,
    // Ajoutez d'autres propriétés au besoin
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      id: json['id'],
      username: json['username'],
      name: json['name'],
      lastName: json['lastname'],
      // Ajoutez d'autres propriétés au besoin
    );
  }
}