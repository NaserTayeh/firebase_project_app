// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'component/second_part.dart';
import 'component/top_part.dart';

class DetailsScreen extends StatelessWidget {
  final String productImage;
  final String productName;
  final String productCategory;
  final String productDescription;
  final num productPrice;
  final num productOldPrice;
  final num productRate;
  final String productId;

  const DetailsScreen(
      {super.key,
      required this.productId,
      required this.productCategory,
      required this.productDescription,
      required this.productImage,
      required this.productName,
      required this.productPrice,
      required this.productOldPrice,
      required this.productRate});

  @override
  Widget build(BuildContext context) {
    print(productId);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TopPart(
              productImage: productImage,
            ),
            SecondPart(
              productCategory: productCategory,
              productImage: productImage,
              productId: productId,
              productDescription: productDescription,
              productName: productName,
              productOldPrice: productOldPrice,
              productPrice: productPrice,
              productRate: productRate,
            ),
          ],
        ),
      ),
    );
  }
}
