import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Themes/app_colors.dart';
import '../provider/my_provider.dart';

class ButtonCusomized extends StatelessWidget {
  const ButtonCusomized({Key? key, required this.text, required this.function})
      : super(key: key);
  final String text;
  final Function() function;
  @override
  Widget build(BuildContext context) {
    getheight(value) {
      num screenHight = MediaQuery.of(context).size.height;
      return (value / 812.0) * screenHight;
    }

    return SizedBox(
      width: double.infinity,
      height: getheight(56),
      child: FlatButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          color: Provider.of<MyProvider>(context).isDarkMode
              ? AppColors.kwhiteColor
              : Color.fromARGB(255, 17, 65, 124),
          onPressed: function,
          child: Text(
            text,
            style: TextStyle(
                fontSize: getheight(18), color: AppColors.kwhiteColor),
          )),
    );
  }
}
