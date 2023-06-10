import 'package:final_project_firebase/Themes/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../model/product_model.dart';

class ProductImages extends StatefulWidget {
  const ProductImages({
    Key? key,
    required this.productImage,
    required this.productId,
  }) : super(key: key);

  final String productImage;
  final String productId;

  @override
  _ProductImagesState createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  int selectedImage = 0;
  @override
  Widget build(BuildContext context) {
    double getWidth(value) {
      double screenWidth = MediaQuery.of(context).size.width;
      return (value / 375.0) * screenWidth;
    }

    GestureDetector buildSmallProductPreview(int index) {
      return GestureDetector(
        onTap: () {
          setState(() {
            selectedImage = index;
          });
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          margin: EdgeInsets.only(right: 15),
          padding: EdgeInsets.all(8),
          height: (48),
          width: getWidth(48),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: AppColors.kPrimaryColor
                    .withOpacity(selectedImage == index ? 1 : 0)),
          ),
          child: Image.network(widget.productImage),
        ),
      );
    }

    return Column(
      children: [
        SizedBox(
          width: getWidth(238),
          child: AspectRatio(
            aspectRatio: 1,
            child: Hero(
              tag: widget.productId.toString(),
              child: Image.network(widget.productImage),
            ),
          ),
        ),
        // SizedBox(height: getProportionateScreenWidth(20)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(1, (index) => buildSmallProductPreview(index)),
          ],
        )
      ],
    );
  }
}
