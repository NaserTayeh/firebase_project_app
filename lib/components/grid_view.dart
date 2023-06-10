// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_firebase/components/product_widget.dart';
import 'package:final_project_firebase/data_reposotries/fire_store_helper.dart';
import 'package:final_project_firebase/model/product_model.dart';
import 'package:final_project_firebase/provider/my_provider.dart';
import 'package:final_project_firebase/router/app_router.dart';
import 'package:final_project_firebase/views/details/details_screen.dart';
import 'package:final_project_firebase/views/home/components/product_cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Themes/app_colors.dart';

class GridViewWidget extends StatefulWidget {
  GridViewWidget({
    Key? key,
    required this.subCollection,
    required this.id,
    required this.collection,
  }) : super(key: key);
  String? id;
  String? collection;
  String? subCollection;
  @override
  State<GridViewWidget> createState() => _GridViewWidgetState();
}

class _GridViewWidgetState extends State<GridViewWidget> {
  String query = "";

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
    // log();
    log(widget.subCollection.toString());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: FireStoreHelper.fireStoreHelper.firestore
              .collection(widget.collection!)
              .doc(widget.id)
              .collection(widget.subCollection!)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            var varData = searchFunction(
                Provider.of<MyProvider>(context).query, snapshot.data!.docs);
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    elevation: 7,
                    shadowColor: Colors.grey[300],
                    child: TextFormField(
                      style: TextStyle(
                          color: Provider.of<MyProvider>(context).isDarkMode
                              ? Colors.white
                              : AppColors.kTextColor),
                      onChanged: (value) {
                        Provider.of<MyProvider>(context, listen: false)
                            .setQuery(value);
                        // setState(() {});
                      },
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search,
                              color: Provider.of<MyProvider>(context).isDarkMode
                                  ? Colors.white
                                  : Colors.black),
                          fillColor: Provider.of<MyProvider>(context).isDarkMode
                              ? Colors.transparent
                              : Colors.white,
                          hintText: "Search Your Product",
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(50))),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                result.isEmpty
                    ? Center(child: Text("Not Found"))
                    : SingleChildScrollView(
                        child: GridView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: result.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 5.0,
                            mainAxisSpacing: 5.0,
                            childAspectRatio: 0.6,
                          ),
                          itemBuilder: (ctx, index) {
                            var data = varData[index];
                            List<Product>? products =
                                Provider.of<MyProvider>(context).allProduct;
                            log(data.toString());
                            // Product product = Product.fromMap(data);
                            log('result is' + result.length.toString());

                            return ProductCard(
                              productCategory: data['productCategory'],
                              productDescription: data["productDescription"],
                              productOldPrice: data["productOldPrice"],
                              productId: data["productId"],
                              productRate: data["productRate"],
                              productPrice: data["productPrice"],
                              productImage: data["productImage"],
                              productName: data["productName"],
                            );
                            // );
                          },
                        ),
                      ),
                // snapshot.data!.docs.isEmpty
                //     ? Center(child: Text('No Favorite yer'))
                //     : GridView.builder(
                //         shrinkWrap: true,
                //         itemCount: snapshot.data!.docs.length,
                //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //             childAspectRatio: 0.4,
                //             crossAxisCount: 2,
                //             mainAxisSpacing: 5,
                //             crossAxisSpacing: 5),
                //         itemBuilder: (context, index) {
                //           var data = snapshot.data!.docs[index];
                //           return ProductWidget(
                //             onTap: () {
                //               AppRouter.appRouter.goToWidget(DetailsScreen(
                //                 productCategory: snapshot.data!.docs[index]
                //                     ['productCategory'],
                //                 productId: snapshot.data!.docs[index]
                //                     ['productImage'],
                //                 productImage: snapshot.data!.docs[index]
                //                     ['productImage'],
                //                 productName: snapshot.data!.docs[index]
                //                     ['productName'],
                //                 productOldPrice: snapshot.data!.docs[index]
                //                     ['productOldPrice'],
                //                 productPrice: snapshot.data!.docs[index]
                //                     ['productPrice'],
                //                 productRate: snapshot.data!.docs[index]
                //                     ['productRate'],
                //                 productDescription: snapshot.data!.docs[index]
                //                     ['productDescription'],
                //               ));
                //             },
                //             productCategory: data['productCategory'],
                //             // productFavorite: true,
                //             productId: data['productId'],
                //             productOldPrice: data['productOldPrice'],
                //             productRate: data['productRate'],
                //             productImage: data['productImage'],
                //             productName: data['productName'],
                //             productPrice: data['productPrice'],
                //           );
                //         },
                //       ),
              ],
            );
          },
        ),
      ),
    );
  }
}
