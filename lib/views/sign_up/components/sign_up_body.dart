// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:final_project_firebase/Themes/app_colors.dart';
import 'package:final_project_firebase/views/sign_up/components/sign_up_foem.dart';
import 'package:flutter/material.dart';

class SignupBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double getWidth(value) {
      double screenWidth = MediaQuery.of(context).size.width;
      return (value / 375.0) * screenWidth;
    }

    getheight(value) {
      num screenHight = MediaQuery.of(context).size.height;
      return (value / 812.0) * screenHight;
    }

    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "Sign Up",
                  style: TextStyle(color: AppColors.kTextColor, fontSize: 20),
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04), // 4%
                Text(
                  "New Account",
                  style: TextStyle(
                    fontSize: getWidth(28),
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    height: 1.5,
                  ),
                ),
                Text(
                  "",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                SignUpForm(),
                SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
