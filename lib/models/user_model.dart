// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  final String id;
  final String name;
  final String email;
  final String? password;
  final String type;
  final String address;
  final String token;
  final double userBalance;
  final String payID;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.password,
    required this.address,
    required this.type,
    required this.token,
    required this.userBalance,
    required this.payID,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'address': address,
      'type': type,
      'token': token,
      'userBalance': userBalance,
      'payID': payID,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'],
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      address: map['address'] ?? '',
      type: map['type'] ?? '',
      token: map['token'] ?? '',
      userBalance: map['user_balance']?.toDouble() ?? 0.0,
      payID: map['payID'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    String? type,
    String? address,
    String? token,
    double? userBalance,
    String? payID,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      type: type ?? this.type,
      address: address ?? this.address,
      token: token ?? this.token,
      userBalance: userBalance ?? this.userBalance,
      payID: payID ?? this.payID,
    );
  }
}
