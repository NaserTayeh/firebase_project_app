// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, unnecessary_this
// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:final_project_firebase/Themes/app_colors.dart';
import 'package:final_project_firebase/provider/my_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class CustomButton extends StatelessWidget {
  void Function()? function;
  String text;
  CustomButton({
    Key? key,
    required this.function,
    required this.text,
  }) : super(key: key);
  List<Color> list1 = [
    Color.fromARGB(255, 2, 15, 67),
    Color.fromARGB(255, 70, 69, 97)
  ];
  List<Color> list2 = [
    Color.fromARGB(255, 119, 124, 124),
    Color.fromARGB(255, 8, 13, 14)
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: this.function,
      height: 50,
      padding: EdgeInsets.all(0),
      child: Ink(
        child: Container(
          height: 50,
          alignment: Alignment.center,
          child: Text(
            this.text,
            style: TextStyle(color: AppColors.kwhiteColor),
          ),
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: Provider.of<MyProvider>(context).isDarkMode
                    ? [...list2]
                    : [...list1])),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(04)),
    );
  }
}
