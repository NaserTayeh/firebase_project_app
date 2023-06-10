// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

class Product {
  String id;
  String name, description;
  String image;
  num rating, price;
  bool isFavourite, isPopular;

  Product({
    required this.id,
    required this.image,
    this.rating = 0.0,
    this.isFavourite = false,
    this.isPopular = false,
    required this.name,
    required this.price,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productDescription': description,
      'productImages': image,
      'productPrice': price,
      'productName': name,
      'productRate': rating
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
        id: map['productId'],
        description: map['productDescription'],
        image: map['productImages'],
        price: map['productPrice'],
        name: map['productName']);
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);
}
