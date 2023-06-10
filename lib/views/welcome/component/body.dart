// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last

import 'package:final_project_firebase/Themes/app_colors.dart';
import 'package:final_project_firebase/data/constant.dart';
import 'package:final_project_firebase/provider/my_provider.dart';
import 'package:final_project_firebase/router/app_router.dart';
import 'package:final_project_firebase/views/login/sign_in_screen.dart';
import 'package:final_project_firebase/views/welcome/component/splash_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/custom_button2.dart';

class BodyPart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double getWidth(value) {
      double screenWidth = MediaQuery.of(context).size.width;
      // 375 is the layout width that designer use
      return (value / 375.0) * screenWidth;
    }

    Widget buildSlider({int? i}) {
      return AnimatedContainer(
        duration: Duration(milliseconds: 200),
        margin: EdgeInsets.only(right: 5),
        height: 6,
        width: Provider.of<MyProvider>(context).currentPage == i ? 20 : 6,
        decoration: BoxDecoration(
            color: Provider.of<MyProvider>(context).currentPage == i
                ? AppColors.kPrimaryColor
                : AppColors.kSecondaryColor,
            borderRadius: BorderRadius.circular(3)),
      );
    }

    return SafeArea(
      child: Center(
        child: Column(
          children: [
            Expanded(
                flex: 3,
                child: PageView.builder(
                  onPageChanged: (value) {
                    Provider.of<MyProvider>(context, listen: false)
                        .changeCurrentPage(value);
                  },
                  itemCount: splachData.length,
                  itemBuilder: (context, index) {
                    return SplashContent(
                      title: splachData[index]['text'],
                      image: splachData[index]['image'],
                    );
                  },
                )),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int i = 0; i < splachData.length; i++)
                          buildSlider(i: i)
                      ],
                    ),
                    Spacer(
                      flex: 3,
                    ),
                    ButtonCusomized(
                      text: 'Go to Login',
                      function: () {
                        AppRouter.appRouter.goToWidget(SignInScreen());
                      },
                    ),
                    Spacer()
                  ],
                ),
              ),
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }
}
