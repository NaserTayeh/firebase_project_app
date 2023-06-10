// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_firebase/Auth/auth_helper.dart';
import 'package:final_project_firebase/components/custom_button.dart';
import 'package:final_project_firebase/router/app_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../Themes/app_colors.dart';
import '../../../data_reposotries/fire_store_helper.dart';
import '../../cart/cart_screen.dart';

class SecondPart extends StatelessWidget {
  final String productName;
  final num productPrice;
  final num productOldPrice;
  final num productRate;
  final String productDescription;
  final String productId;
  final String productImage;
  final String productCategory;
  const SecondPart({
    Key? key,
    required this.productCategory,
    required this.productImage,
    required this.productId,
    required this.productDescription,
    required this.productName,
    required this.productPrice,
    required this.productOldPrice,
    required this.productRate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            productName,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              Text("\$$productPrice"),
              SizedBox(
                width: 20,
              ),
              Text(
                "\$$productOldPrice",
                style: TextStyle(
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Divider(
                thickness: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: AppColors.kgradient1,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(
                      child: Text(
                        productRate.toString(),
                        style: TextStyle(
                          color: AppColors.kwhiteColor,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "50 Reviews",
                    style: TextStyle(
                      color: AppColors.kgradient1,
                    ),
                  )
                ],
              ),
              Divider(
                thickness: 2,
              ),
            ],
          ),
          Text(
            "Description",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            productDescription,
            style: TextStyle(),
          ),
          CustomButton(
            function: () {
              AppRouter.appRouter.goToWidget(CartScreen());
              FireStoreHelper.fireStoreHelper.firestore
                  .collection('cart')
                  .doc(AuthHelper.authHelper.firebaseAuth.currentUser!.uid)
                  .collection('userCart')
                  .doc(productId)
                  .set({
                "productId": productId,
                "productImage": productImage,
                "productName": productName,
                "productPrice": productPrice,
                "productOldPrice": productOldPrice,
                "productRate": productRate,
                "productDescription": productDescription,
                "productQuantity": 1,
                "productCategory": productCategory
              });
            },
            text: "Add to Cart",
          ),
        ],
      ),
    );
  }
}
