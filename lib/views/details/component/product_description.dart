import 'package:final_project_firebase/Themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../model/product_model.dart';

class ProductDescription extends StatelessWidget {
  ProductDescription(
      {Key? key,
      // required this.product,
      this.pressOnSeeMore,
      required this.productDescription,
      required this.productName,
      required this.productPrice,
      required this.productOldPrice})
      : super(key: key);

  // final Product product;
  GestureTapCallback? pressOnSeeMore;
  String productDescription;
  String productName;
  bool? productFavorite;
  num productPrice;
  num productOldPrice;

  @override
  Widget build(BuildContext context) {
    double getWidth(value) {
      double screenWidth = MediaQuery.of(context).size.width;
      return (value / 375.0) * screenWidth;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
          child: Text(
            productName,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            padding: EdgeInsets.all(getWidth(15)),
            width: getWidth(64),
            decoration: BoxDecoration(
              color: productFavorite ?? true
                  ? Color(0xFFFFE6E6)
                  : Color(0xFFF5F6F9),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            child: SvgPicture.asset(
              "assets/icons/Heart Icon_2.svg",
              color: productFavorite ?? true
                  ? Color(0xFFFF4848)
                  : Color(0xFFDBDEE4),
              height: getWidth(16),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: getWidth(20),
            right: getWidth(64),
          ),
          child: Text(
            productDescription,
            maxLines: 3,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getWidth(20),
            vertical: 10,
          ),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Divider(),
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
            ],
          ),
        ),
      ],
    );
  }
}
