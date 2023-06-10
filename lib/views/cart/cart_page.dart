// ignore_for_file: prefer_const_constructors

import 'package:final_project_firebase/Themes/app_colors.dart';
import 'package:final_project_firebase/model/cart_m.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/cart_provider.dart';
import 'components/cart_body.dart';
import 'components/checkout_card.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: CartBody(),
      bottomNavigationBar: Provider.of<CartProvider>(context).cartList.isEmpty
          ? Text('')
          : CheckoutCard(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Your Cart",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
