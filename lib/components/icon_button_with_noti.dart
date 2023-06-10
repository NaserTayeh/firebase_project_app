import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../Themes/app_colors.dart';

class IconButtonCounter extends StatelessWidget {
  final String svgSrc;
  final int numOfItems;
  final GestureTapCallback press;

  const IconButtonCounter(
      {super.key,
      required this.svgSrc,
      required this.numOfItems,
      required this.press});

  @override
  Widget build(BuildContext context) {
    double getWidth(value) {
      double screenWidth = MediaQuery.of(context).size.width;
      return (value / 375.0) * screenWidth;
    }

    return InkWell(
      onTap: press,
      borderRadius: BorderRadius.circular(50),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: EdgeInsets.all(getWidth(12)),
            height: getWidth(46),
            width: getWidth(46),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.kSecondaryColor.withOpacity(0.1)),
            child: SvgPicture.asset(svgSrc),
          ),
          if (numOfItems != 0)
            Positioned(
              top: -3,
              right: 0,
              child: Container(
                height: getWidth(16),
                width: getWidth(16),
                decoration: BoxDecoration(
                    color: Color(0xFFFF4848),
                    shape: BoxShape.circle,
                    border:
                        Border.all(width: 1.5, color: AppColors.kwhiteColor)),
                child: Center(
                    child: Text(
                  '$numOfItems',
                  style: TextStyle(
                      height: 1,
                      fontWeight: FontWeight.w600,
                      color: AppColors.kwhiteColor,
                      fontSize: getWidth(10)),
                )),
              ),
            )
        ],
      ),
    );
  }
}
