import 'package:final_project_firebase/Themes/app_colors.dart';
import 'package:final_project_firebase/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../components/def_btn.dart';
import '../../checkout/checkout_screen.dart';

class CheckoutCard extends StatelessWidget {
  const CheckoutCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getheight(value) {
      num screenHight = MediaQuery.of(context).size.height;
      return (value / 812.0) * screenHight;
    }

    double getWidth(value) {
      double screenWidth = MediaQuery.of(context).size.width;
      return (value / 375.0) * screenWidth;
    }

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: getWidth(15),
        horizontal: getWidth(30),
      ),
      // height: 174,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  height: getWidth(40),
                  width: getWidth(40),
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F6F9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SvgPicture.asset("assets/icons/receipt.svg"),
                ),
                Spacer(),
                const SizedBox(width: 10),
              ],
            ),
            SizedBox(height: getheight(20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Text.rich(
                //   TextSpan(
                //     text: "Total:\n",
                //     children: [
                //       TextSpan(
                //         text: "\$$totalPrice",
                //         style: TextStyle(fontSize: 16, color: Colors.black),
                //       ),
                //     ],
                //   ),
                // ),
                SizedBox(
                  width: getWidth(200),
                  child: DefaultButton(
                    text: "Check Out",
                    press: () {
                      AppRouter.appRouter.goToWidget(CheckoutScreen());
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
