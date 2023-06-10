// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'package:final_project_firebase/components/cart_widget.dart';
import 'package:final_project_firebase/components/custom_button.dart';
import 'package:final_project_firebase/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../router/app_router.dart';
import '../checkout/checkout_screen.dart';
import '../details/details_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<CartProvider>(context).getCartData();
    return Scaffold(
      bottomNavigationBar: Provider.of<CartProvider>(context).cartList.isEmpty
          ? Text('')
          : CustomButton(
              function: () {
                AppRouter.appRouter.goToWidget(CheckoutScreen());
              },
              text: 'Check Out'),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Consumer<CartProvider>(
        builder: (context, provider, w) {
          return provider.cartList.isEmpty
              ? Center(
                  child: Text('No Product Yet'),
                )
              : ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    var data = provider.cartList[index];
                    return CartElementWidget(
                      productCategory: data.productCategory,
                      productId: data.productId,
                      productImage: data.productImage,
                      productPrice: data.productPrice,
                      productQuantity: data.productQuantity,
                      productName: data.productName,
                    );
                  },
                  itemCount: provider.getCartList().length,
                );
        },
      ),
    );
  }
}
