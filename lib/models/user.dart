import 'dart:convert';

class User {
  final String name;
  final String id;
  final String email;
  final String password;
  final String address;
  final String type;
  final String token;

  User(
      {required this.address,
      required this.email,
      required this.id,
      required this.name,
      required this.password,
      required this.token,
      required this.type});

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
        address: map['address'] ?? '',
        email: map['email'] ?? '',
        id: map['_id'] ?? '',
        name: map['name'] ?? '',
        password: map['password'] ?? '',
        token: map['token'] ?? '',
        type: map['type'] ?? '');
  }

  Map<String, dynamic> toMap() => {
        "name": this.name,
        "email": this.email,
        "password": this.password,
        "_id": this.id,
        "address": this.address,
        "type": this.type,
        "token": this.token
      };

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
