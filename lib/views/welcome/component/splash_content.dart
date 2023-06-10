import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../Themes/app_colors.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({Key? key, required this.title, required this.image})
      : super(key: key);
  final String title, image;
  @override
  Widget build(BuildContext context) {
    getheight(value) {
      num screenHight = MediaQuery.of(context).size.height;
      return (value / 812.0) * screenHight;
    }

    return Column(
      children: [
        Spacer(),
        Text(
          'Protine Shop',
          style: TextStyle(
              fontSize: getheight(36),
              color: AppColors.kPrimaryColor,
              fontWeight: FontWeight.bold),
        ),
        Text(
          title,
          textAlign: TextAlign.center,
        ),
        Spacer(
          flex: 2,
        ),
        SvgPicture.asset(
          image,
          height: getheight(265),
          width: getheight(235),
        )
      ],
    );
  }
}
