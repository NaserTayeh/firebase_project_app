// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:final_project_firebase/components/custom_button.dart';
import 'package:final_project_firebase/views/login/components/center_part_login.dart';
import 'package:final_project_firebase/views/login/components/end_part_login.dart';
import 'package:final_project_firebase/views/login/components/top_part_login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // top part
            TopPartLogin(),
            // center part
            CenterPartLogin(),
            //end part
            EndPartLogin()

            // ),
          ],
        ),
      ),
    );
  }
}
