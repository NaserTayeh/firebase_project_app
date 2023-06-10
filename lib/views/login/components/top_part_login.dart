// ignore_for_file: prefer_const_constructors

import 'package:final_project_firebase/Themes/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class TopPartLogin extends StatelessWidget {
  const TopPartLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                'https://images.unsplash.com/photo-1545231027-637d2f6210f8?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8bG9nb3xlbnwwfHwwfHw%3D&auto=format&fit=crop&w=1000&q=60',
                scale: 8,
              ),
            ),
            SizedBox(
              height: 7,
            ),
            Text(
              'Login',
              style: TextStyle(
                  fontSize: 20,
                  color: AppColors.kblackColor,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ],
    );
  }
}
