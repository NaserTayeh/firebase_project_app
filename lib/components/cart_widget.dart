// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:final_project_firebase/provider/my_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartElementWidget extends StatelessWidget {
  final String productImage;
  final String productName;
  final num productPrice;
  final num productQuantity;
  final String productCategory;
  final String productId;

  const CartElementWidget(
      {super.key,
      required this.productImage,
      required this.productId,
      required this.productCategory,
      required this.productName,
      required this.productPrice,
      required this.productQuantity});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity,
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(color: Colors.grey.withOpacity(0.7), blurRadius: 7)
      ]),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Row(
            children: [
              Expanded(
                  child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        productImage,
                      )),
                ),
              )),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      productName,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      productCategory,
                      style: TextStyle(),
                    ),
                    Text(
                      '\$ ${productPrice * productQuantity} ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IncrementAndDecrement(
                          icon: Icons.add,
                          onPressed: () {
                            Provider.of<MyProvider>(context, listen: false)
                                .incrementQuantity();
                            Provider.of<MyProvider>(context, listen: false)
                                .updateQuantity(productId);
                          },
                        ),
                        Text(
                          productQuantity.toString(),
                          style: TextStyle(fontSize: 18),
                        ),
                        IncrementAndDecrement(
                          icon: Icons.remove,
                          onPressed: () {
                            if (Provider.of<MyProvider>(context, listen: false)
                                    .quantity >
                                1) {
                              Provider.of<MyProvider>(context, listen: false)
                                  .decrementQuantity();
                              Provider.of<MyProvider>(context, listen: false)
                                  .updateQuantity(productId);
                            }
                          },
                        )
                      ],
                    )
                  ],
                ),
              )),
            ],
          ),
          IconButton(
              onPressed: () {
                Provider.of<MyProvider>(context, listen: false)
                    .deleteItemFromCart(productId);
              },
              icon: Icon(Icons.close))
        ],
      ),
    );
  }
}

class IncrementAndDecrement extends StatelessWidget {
  final Function()? onPressed;
  final IconData icon;

  const IncrementAndDecrement({super.key, this.onPressed, required this.icon});
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      minWidth: 40,
      height: 30,
      elevation: 2,
      color: Colors.grey[300],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Icon(icon),
    );
  }
}
