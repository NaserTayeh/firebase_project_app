// ignore_for_file: prefer_const_literals_to_create_immutables, sort_child_properties_last, prefer_const_constructors

import 'package:final_project_firebase/Themes/app_colors.dart';
import 'package:final_project_firebase/components/custom_button.dart';
import 'package:final_project_firebase/router/app_router.dart';
import 'package:final_project_firebase/views/login/login_screen.dart';
import 'package:final_project_firebase/views/sign_up/sign_up_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class EndPart extends StatelessWidget {
  const EndPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomButton(
            function: () {
              AppRouter.appRouter.goToWidget(LoginScreen());
            },
            text: "LOG IN"),
        // MaterialButton(
        //   onPressed: () {},
        //   height: 50,
        //   padding: EdgeInsets.all(0),
        //   child: Ink(
        //     child: Container(
        //       height: 50,
        //       alignment: Alignment.center,
        //       child: Text(
        //         'Log In',
        //         style: TextStyle(color: Colors.white),
        //       ),
        //     ),
        //     decoration: BoxDecoration(
        //         borderRadius: BorderRadius.circular(15),
        //         gradient: LinearGradient(
        //             begin: Alignment.centerLeft,
        //             end: Alignment.centerRight,
        //             colors: [
        //               Color.fromARGB(255, 4, 68, 77),
        //               Color.fromARGB(255, 52, 173, 188)
        //             ])),
        //   ),
        //   shape:
        //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(04)),
        // ),
        SizedBox(
          height: 20,
        ),
        GestureDetector(
            onTap: () {},
            child: InkWell(
              onTap: () {
                AppRouter.appRouter.goToWidget(SignupScreen());
              },
              child: Text(
                'SIGN UP ',
                style: TextStyle(color: AppColors.kgreyColor),
              ),
            ))
      ],
    );
  }
}
