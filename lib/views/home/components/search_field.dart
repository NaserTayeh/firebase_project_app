import 'package:final_project_firebase/provider/my_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Themes/app_colors.dart';

class SearchPart extends StatelessWidget {
  const SearchPart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double getWidth(value) {
      double screenWidth = MediaQuery.of(context).size.width;
      return (value / 375.0) * screenWidth;
    }

    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.kSecondaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        style: TextStyle(
            color: Provider.of<MyProvider>(context).isDarkMode
                ? AppColors.kwhiteColor
                : AppColors.kTextColor),
        onChanged: (value) {
          Provider.of<MyProvider>(context, listen: false).setQuery(value);
        },
        decoration: InputDecoration(
            errorBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            hintText: 'Search Product',
            prefixIcon: Icon(Icons.search),
            contentPadding: EdgeInsets.symmetric(
                horizontal: getWidth(20), vertical: getWidth(9))),
      ),
    );
  }
}
