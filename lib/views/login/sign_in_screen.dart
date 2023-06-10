// ignore_for_file: prefer_const_constructors

import 'package:final_project_firebase/Themes/app_colors.dart';
import 'package:flutter/material.dart';

import 'components/loginbody.dart';

class SignInScreen extends StatelessWidget {
  static String routeName = "/sign_in";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        // backgroundColor: Colors.w,
        // title: Text(
        //   "Sign In",
        //   style: TextStyle(color: AppColors.kTextColor),
        // ),
      ),
      body: Body(),
    );
  }
}
