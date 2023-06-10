// ignore_for_file: prefer_const_constructors

import 'package:final_project_firebase/Themes/app_colors.dart';
import 'package:final_project_firebase/model/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/cart_m.dart';
import '../../../provider/my_provider.dart';

class CartCard extends StatelessWidget {
  const CartCard({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final CartModel cart;

  @override
  Widget build(BuildContext context) {
    double getWidth(value) {
      double screenWidth = MediaQuery.of(context).size.width;
      return (value / 375.0) * screenWidth;
    }

    return Row(
      children: [
        SizedBox(
          width: 88,
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              padding: EdgeInsets.all(getWidth(10)),
              decoration: BoxDecoration(
                color: Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.network(cart.productImage),
            ),
          ),
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cart.productName,
              style: TextStyle(
                  color: Provider.of<MyProvider>(context).isDarkMode
                      ? AppColors.kwhiteColor
                      : Colors.black,
                  fontSize: 16),
              maxLines: 2,
            ),
            SizedBox(height: 10),
            Text.rich(
              TextSpan(
                text: "\$${cart.productPrice * cart.productQuantity}",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Provider.of<MyProvider>(context).isDarkMode
                        ? AppColors.kwhiteColor
                        : AppColors.kPrimaryColor),
                children: [
                  TextSpan(
                      text: "", style: Theme.of(context).textTheme.bodyText1),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IncrementAndDecrement(
                  icon: Icons.add,
                  onPressed: () {
                    Provider.of<MyProvider>(context, listen: false)
                        .incrementQuantity();
                    Provider.of<MyProvider>(context, listen: false)
                        .updateQuantity(cart.productId);
                  },
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  cart.productQuantity.toString(),
                  style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: Provider.of<MyProvider>(context).isDarkMode
                          ? AppColors.kwhiteColor
                          : AppColors.kTextColor),
                ),
                SizedBox(
                  width: 10,
                ),
                IncrementAndDecrement(
                  icon: Icons.remove,
                  onPressed: () {
                    if (Provider.of<MyProvider>(context, listen: false)
                            .quantity >
                        1) {
                      Provider.of<MyProvider>(context, listen: false)
                          .decrementQuantity();
                      Provider.of<MyProvider>(context, listen: false)
                          .updateQuantity(cart.productId);
                    }
                  },
                )
              ],
            )
          ],
        )
      ],
    );
  }
}

class IncrementAndDecrement extends StatelessWidget {
  final Function()? onPressed;
  final IconData icon;

  const IncrementAndDecrement({super.key, this.onPressed, required this.icon});
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      minWidth: 40,
      height: 30,
      elevation: 2,
      color: Colors.grey[300],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Icon(icon),
    );
  }
}
