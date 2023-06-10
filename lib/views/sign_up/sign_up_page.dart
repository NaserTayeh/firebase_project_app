// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

import 'components/sign_up_body.dart';

class SignUpPage extends StatelessWidget {
  static String routeName = "/sign_up";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        // title: Text("Sign Up"),
      ),
      body: SignupBody(),
    );
  }
}
