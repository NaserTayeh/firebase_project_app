import 'package:final_project_firebase/Themes/app_colors.dart';
import 'package:final_project_firebase/provider/favourite_provider.dart';
import 'package:final_project_firebase/provider/my_provider.dart';
import 'package:final_project_firebase/router/app_router.dart';
import 'package:final_project_firebase/views/details/details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../Auth/auth_helper.dart';
import '../../../data_reposotries/fire_store_helper.dart';
import '../../../model/product_model.dart';

class ProductCard extends StatefulWidget {
  ProductCard({
    Key? key,
    this.width = 140,
    this.aspectRetio = 1.02,
    required this.productId,
    required this.productRate,
    required this.productPrice,
    required this.productOldPrice,
    required this.productImage,
    required this.productName,
    required this.productDescription,
    required this.productCategory,
  }) : super(key: key);

  final double width, aspectRetio;
  // final Product product;
  String productId;
  num productRate;
  num productPrice;
  num productOldPrice;
  String productDescription;
  String productImage;
  String productName;
  String productCategory;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isFav = false;
  @override
  Widget build(BuildContext context) {
    double getWidth(value) {
      double screenWidth = MediaQuery.of(context).size.width;
      return (value / 375.0) * screenWidth;
    }

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
    return Padding(
      padding: EdgeInsets.only(left: getWidth(20)),
      child: SizedBox(
        width: (widget.width),
        child: GestureDetector(
          onTap: () => AppRouter.appRouter.goToWidget(DetailsPage(
            productCategory: widget.productCategory,
            productOldPrice: widget.productOldPrice,
            productId: widget.productId,
            productImage: widget.productImage,
            productName: widget.productName,
            productRate: widget.productRate,
            productPrice: widget.productPrice,
            productDescription: widget.productDescription,
          )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1.02,
                child: Container(
                  // padding: EdgeInsets.all(getWidth(20)),
                  decoration: BoxDecoration(
                    color: AppColors.kSecondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Hero(
                    tag: widget.productId.toString(),
                    child: Image.network(
                      widget.productImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                widget.productName,
                style: TextStyle(
                    color: Provider.of<MyProvider>(context).isDarkMode
                        ? Colors.white70
                        : Colors.black),
                maxLines: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "\$${widget.productPrice}",
                    style: TextStyle(
                      fontSize: getWidth(18),
                      fontWeight: FontWeight.w600,
                      color: Provider.of<MyProvider>(context).isDarkMode
                          ? Colors.white
                          : AppColors.kPrimaryColor,
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () {
                      setState(() {
                        isFav = !isFav;
                        if (isFav) {
                          Provider.of<FavouriteProvider>(context, listen: false)
                              .favouriteFunction(
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
                          Provider.of<FavouriteProvider>(context, listen: false)
                              .removeFavourite(productId: widget.productId);
                        }
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(getWidth(8)),
                      height: getWidth(28),
                      width: getWidth(28),
                      decoration: BoxDecoration(
                        color: /*product.isFavourite*/ isFav
                            ? AppColors.kPrimaryColor.withOpacity(0.15)
                            : AppColors.kSecondaryColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        "assets/icons/Heart Icon_2.svg",
                        color: isFav ? Color(0xFFFF4848) : Color(0xFFDBDEE4),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
