import 'dart:convert';

import 'package:amazon_clone/models/rating.dart';

class Product {
  final String name;
  final String description;
  final double quantity;
  final double price;
  final String category;
  final List<String> images;
  final String? id;
  final List<Rating>? ratings;
//  final String? userId;

  Product({
    required this.name,
    required this.description,
    required this.quantity,
    required this.price,
    required this.category,
    required this.images,
    this.id,
    this.ratings,

    //  required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'quantity': quantity,
      'images': images,
      'category': category,
      'price': price,
      'id': id,
      'ratings': ratings
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
        name: map['name'] ?? '',
        description: map['description'] ?? '',
        quantity: map['quantity']?.toDouble() ?? 0.0,
        images: List<String>.from(map['images']),
        category: map['category'] ?? '',
        price: map['price']?.toDouble() ?? 0.0,
        id: map['_id'],
        ratings: map["ratings"] != null
            ? List<Rating>.from(
                map['ratings']?.map((x) => Rating.fromMap(x)),
              )
            : null
        // userId: map['userId']
        );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));
}
