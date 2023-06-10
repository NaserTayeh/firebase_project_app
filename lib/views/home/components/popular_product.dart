// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_firebase/provider/my_provider.dart';
import 'package:final_project_firebase/views/home/components/product_cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/constant.dart';
import 'section_title.dart';

class PopularProducts extends StatefulWidget {
  @override
  State<PopularProducts> createState() => _PopularProductsState();
}

String query = "";

class _PopularProductsState extends State<PopularProducts> {
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

  @override
  Widget build(BuildContext context) {
    double getWidth(value) {
      double screenWidth = MediaQuery.of(context).size.width;
      return (value / 375.0) * screenWidth;
    }

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
          child: SectionTitle(title: "Popular Products", press: () {}),
        ),
        SizedBox(height: getWidth(20)),

        Container(
          height: MediaQuery.of(context).size.height / 3 + 40,
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("products")
                .where("productRate", isGreaterThan: 3)
                .orderBy(
                  "productRate",
                  descending: true,
                )
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshort) {
              if (!streamSnapshort.hasData) {
                return Center(child: const CircularProgressIndicator());
              }
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                itemCount: streamSnapshort.data!.docs.length,
                itemBuilder: (ctx, index) {
                  var varData = searchFunction(
                      Provider.of<MyProvider>(context).query,
                      streamSnapshort.data!.docs);
                  var data = varData[index];
                  // var data = streamSnapshort.data!.docs[index];
                  return ProductCard(
                    productCategory: data['productCategory'],
                    productOldPrice: data['productOldPrice'],
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
        )

        // SingleChildScrollView(
        //   scrollDirection: Axis.horizontal,
        //   child: Row(
        //     children: [
        // ...List.generate(
        //   demoProducts.length,
        //   (index) {
        //     if (demoProducts[index].isPopular)
        //       return ProductCard(product: demoProducts[index]);

        //     return SizedBox
        //         .shrink(); // here by default width and height is 0
        //   },
        // ),
        //       SizedBox(width: getWidth(20)),
        //     ],
        //   ),
        // )
      ],
    );
  }
}
