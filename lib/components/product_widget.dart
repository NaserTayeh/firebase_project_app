// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:final_project_firebase/Auth/auth_helper.dart';
import 'package:final_project_firebase/data_reposotries/fire_store_helper.dart';
import 'package:final_project_firebase/provider/favourite_provider.dart';
import 'package:final_project_firebase/provider/my_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductWidget extends StatefulWidget {
  final productId,
      productCategory,
      productRate,
      productOldPrice,
      productPrice,
      productImage,
      // productFavorite,
      productName,
      productDescription;
  final Function()? onTap;

  const ProductWidget(
      {super.key,
      required this.onTap,
      required this.productCategory,
      // required this.productFavorite,
      required this.productId,
      required this.productImage,
      required this.productName,
      required this.productOldPrice,
      required this.productPrice,
      required this.productRate,
      required this.productDescription});

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  bool isFav = false;
  @override
  Widget build(BuildContext context) {
    FireStoreHelper.fireStoreHelper.firestore
        .collection('favorite')
        .doc(AuthHelper.authHelper.firebaseAuth.currentUser!.uid)
        .collection('userFavorite')
        .doc(widget.productId)
        .get()
        .then((value) => {
              if (this.mounted)
                {
                  if (value.exists)
                    {
                      setState((() {
                        isFav = value.get('productFavorite');
                      }))
                    }
                }
            });
    return Consumer<FavouriteProvider>(
      builder: (context, provider, w) {
        return GestureDetector(
          onTap: widget.onTap,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.topRight,
                margin: EdgeInsets.all(12),
                height: 200,
                width: 150,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(widget.productImage),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(20)),
                child: IconButton(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onPressed: () {
                      setState(() {
                        isFav = !isFav;
                        if (isFav) {
                          provider.favouriteFunction(
                              productDescription: widget.productDescription,
                              productId: widget.productId,
                              productCategory: widget.productCategory,
                              productRate: widget.productRate,
                              productOldPrice: widget.productOldPrice,
                              productPrice: widget.productPrice,
                              productImage: widget.productImage,
                              productFavorite: true,
                              productName: widget.productName);
                        } else if (isFav == false) {
                          provider.removeFavourite(productId: widget.productId);
                        }
                      });
                    },
                    icon: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Icon(
                        isFav ? Icons.favorite : Icons.favorite_border,
                        color: Colors.orange[700],
                      ),
                    )),
              ),
              Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    widget.productName,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    '\$${this.widget.productPrice}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
