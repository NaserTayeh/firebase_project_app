// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_firebase/views/home/components/categoryies_part.dart';
import 'package:final_project_firebase/views/home/components/discount_part.dart';
import 'package:final_project_firebase/views/home/components/home_header.dart';
import 'package:final_project_firebase/views/home/components/popular_product.dart';
import 'package:final_project_firebase/views/home/components/product_cart.dart';
import 'package:final_project_firebase/views/home/components/special_offer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../../model/user_model.dart';
import '../../../provider/my_provider.dart';

late UserModel userModel;

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);
  Future getCurrentUserDataFunction() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then(
      (DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          userModel = UserModel.fromMap(documentSnapshot);
        } else {
          print("Document does not exist the database");
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double getWidth(value) {
      double screenWidth = MediaQuery.of(context).size.width;
      return (value / 375.0) * screenWidth;
    }

    var result;
    searchFunction(query, searchList) {
      result = searchList.where((element) {
        return element["productName"].toUpperCase().contains(query) ||
            element["productName"].toLowerCase().contains(query) ||
            element["productName"].toUpperCase().contains(query) &&
                element["productName"].toLowerCase().contains(query);
      }).toList();
      return result;
    }

    getCurrentUserDataFunction();
    return SafeArea(
        child: SingleChildScrollView(
      child: Column(children: [
        SizedBox(height: getWidth(20)),
        HomeHeader(),
        SizedBox(height: getWidth(10)),
        Provider.of<MyProvider>(context).query == ""
            ? Column(
                children: [
                  DiscountBanner(),
                  Categories(),
                  SpecialOffers(),
                  SizedBox(height: getWidth(30)),
                  PopularProducts(),
                  SizedBox(height: getWidth(30)),
                ],
              )
            : Container(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("products")
                      .snapshots(),
                  builder:
                      (context, AsyncSnapshot<QuerySnapshot> streamSnapshort) {
                    if (!streamSnapshort.hasData) {
                      return Center(child: const CircularProgressIndicator());
                    }
                    var varData = searchFunction(
                        Provider.of<MyProvider>(context).query,
                        streamSnapshort.data!.docs);
                    return result.isEmpty
                        ? Center(child: Text("Not Found"))
                        : GridView.builder(
                            shrinkWrap: true,
                            itemCount: result.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 5.0,
                              mainAxisSpacing: 5.0,
                              childAspectRatio: 0.6,
                            ),
                            itemBuilder: (ctx, index) {
                              var data = varData[index];
                              return ProductCard(
                                productCategory: data['productCategory'],
                                productOldPrice: data["productOldPrice"],
                                productDescription: data["productDescription"],
                                productId: data["productId"],
                                productRate: data["productRate"],
                                productPrice: data["productPrice"],
                                productImage: data["productImage"],
                                productName: data["productName"],
                              );
                            },
                          );
                  },
                ),
              ),
      ]),
    ));
  }
}
