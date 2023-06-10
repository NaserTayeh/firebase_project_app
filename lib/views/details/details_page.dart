// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:final_project_firebase/views/cart/cart_page.dart';
import 'package:flutter/material.dart';

import 'package:final_project_firebase/views/details/component/body_details.dart';
import 'package:provider/provider.dart';

import '../../Auth/auth_helper.dart';
import '../../components/def_btn.dart';
import '../../data_reposotries/fire_store_helper.dart';
import '../../model/product_model.dart';
import '../../provider/my_provider.dart';
import '../../router/app_router.dart';
import 'component/custom_appbar.dart';
import 'component/product_description.dart';
import 'component/product_image.dart';
import 'component/top_rounded_container.dart';

class DetailsPage extends StatelessWidget {
  DetailsPage(
      {Key? key,
      required this.productCategory,
      required this.productId,
      required this.productDescription,
      required this.productImage,
      required this.productName,
      required this.productPrice,
      required this.productOldPrice,
      required this.productRate})
      : super(key: key);
  final String productImage;
  final String productName;
  String? productCategory;
  final String productDescription;
  final num productPrice;
  final num productOldPrice;
  final num productRate;
  final String productId;

  @override
  Widget build(BuildContext context) {
    double getWidth(value) {
      double screenWidth = MediaQuery.of(context).size.width;
      return (value / 375.0) * screenWidth;
    }

    return Scaffold(
        backgroundColor: Provider.of<MyProvider>(context).isDarkMode
            ? Color.fromARGB(137, 31, 31, 31)
            : Color(0xFFF5F6F9),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(AppBar().preferredSize.height),
          child: CustomAppBar(rating: productRate),
        ),
        body: ListView(
          children: [
            ProductImages(productImage: productImage, productId: productId),
            TopRoundedContainer(
              color: Provider.of<MyProvider>(context).isDarkMode
                  ? Colors.black54
                  : Colors.white,
              child: Column(
                children: [
                  ProductDescription(
                    productDescription: productDescription,
                    productName: productName,
                    productPrice: productPrice,
                    productOldPrice: productOldPrice,
                    pressOnSeeMore: () {},
                  ),
                  TopRoundedContainer(
                    color: Provider.of<MyProvider>(context).isDarkMode
                        ? Colors.black54
                        : Colors.white,
                    child: Column(
                      children: [
                        TopRoundedContainer(
                          color: Provider.of<MyProvider>(context).isDarkMode
                              ? Colors.black54
                              : Colors.white,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.15,
                              right: MediaQuery.of(context).size.width * 0.15,
                              bottom: getWidth(40),
                              top: getWidth(15),
                            ),
                            child: DefaultButton(
                              text: "Add To Cart",
                              press: () {
                                FireStoreHelper.fireStoreHelper.firestore
                                    .collection('cart')
                                    .doc(AuthHelper.authHelper.firebaseAuth
                                        .currentUser!.uid)
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
                                AppRouter.appRouter.goToWidget(CartPage());
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
