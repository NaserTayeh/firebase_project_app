// ignore_for_file: prefer_const_constructors

import 'package:final_project_firebase/Themes/app_colors.dart';
import 'package:final_project_firebase/router/app_router.dart';
import 'package:final_project_firebase/views/sign_up/sign_up_page.dart';
import 'package:final_project_firebase/views/sign_up/sign_up_screen.dart';
import 'package:flutter/material.dart';

import 'log_in_form.dart';

class Body extends StatelessWidget {
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
                  'Sign in',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                Text(
                  "",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: getWidth(28),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  " ",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                SignForm(),
                SizedBox(height: MediaQuery.of(context).size.height * 0.08),

                SizedBox(height: getheight(20)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don's have an account ? ",
                      style: TextStyle(fontSize: getWidth(16)),
                    ),
                    GestureDetector(
                      onTap: () {
                        AppRouter.appRouter.goToWidget(SignUpPage());
                      },
                      child: Text(
                        "Sign up",
                        style: TextStyle(
                            fontSize: getWidth(16),
                            color: AppColors.kPrimaryColor),
                      ),
                    )
                  ],
                )
                // NoAccountText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
