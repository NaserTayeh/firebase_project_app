import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CartModel {
  final String productCategory;
  final String productId;
  final String productImage;
  final num productPrice;
  final int productQuantity;
  final String productName;
  CartModel({
    required this.productCategory,
    required this.productId,
    required this.productImage,
    required this.productPrice,
    required this.productQuantity,
    required this.productName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productCategory': productCategory,
      'productId': productId,
      'productImage': productImage,
      'productPrice': productPrice,
      'productQuantity': productQuantity,
      'productName': productName,
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      productCategory: map['productCategory'] as String,
      productId: map['productId'] as String,
      productImage: map['productImage'] as String,
      productPrice: map['productPrice'] as num,
      productQuantity: map['productQuantity'] as int,
      productName: map['productName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartModel.fromJson(String source) =>
      CartModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
