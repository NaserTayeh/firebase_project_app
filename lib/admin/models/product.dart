import 'dart:convert';

class Product {
  String? id;
  String catId;
  String name;
  String description;
  num price;
  String imageUrl;
  num? rate;
  Product({
    this.id,
    required this.catId,
    this.rate,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'catId': catId,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      catId: map['productId'] ?? '',
      name: map['productName'] ?? '',
      description: map['productDescription'] ?? '',
      price: map['productPrice'] ?? '',
      imageUrl: map['productImage'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));
}
