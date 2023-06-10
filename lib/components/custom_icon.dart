import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomSurffixIcon extends StatelessWidget {
  const CustomSurffixIcon({
    Key? key,
    required this.svgIcon,
  }) : super(key: key);

  final String svgIcon;

  @override
  Widget build(BuildContext context) {
    double getWidth(value) {
      double screenWidth = MediaQuery.of(context).size.width;
      // 375 is the layout width that designer use
      return (value / 375.0) * screenWidth;
    }

    return Padding(
      padding: EdgeInsets.fromLTRB(
        0,
        getWidth(20),
        getWidth(20),
        getWidth(20),
      ),
      child: SvgPicture.asset(
        svgIcon,
        height: getWidth(18),
      ),
    );
  }
}
