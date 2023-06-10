// ignore_for_file: prefer_const_constructors

import 'package:final_project_firebase/Auth/auth_helper.dart';
import 'package:final_project_firebase/router/app_router.dart';
import 'package:final_project_firebase/views/home/home2_screen.dart';
import 'package:final_project_firebase/views/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';

class LoginAuthProvider extends ChangeNotifier {
  TextEditingController loginEmail = TextEditingController();
  TextEditingController loginPassword = TextEditingController();
  bool loading = false;

  loginValidation(BuildContext context) async {
    if (loginEmail.text.trim().isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Email Addressis empty')));
      return;
    } else if (!isEmail(loginEmail.text)) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Invalid Email Addressis ')));
      return;
    } else if (loginPassword.text.trim().isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(' password empty')));
      return;
    } else if (loginPassword.text.length < 8) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(' password must be 8 or more')));
      return;
    } else {
      try {
        loading = true;
        notifyListeners();
        String? result = await AuthHelper.authHelper
            .signIn(loginEmail.text, loginPassword.text);
        loading = false;
        notifyListeners();
        // await AppRouter.appRouter.goToWidget(HomeScreen());
        await AppRouter.appRouter.goToWidgetAndReplace(MyHome());
        notifyListeners();
      } on FirebaseAuthException catch (e) {
        loading = false;
        notifyListeners();
        if (e.code == "user-not-found") {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('user-not-found')));
        } else if (e.code == "wrong-password") {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('wrong-password')));
        }

        // TODO
      }
    }
  }
}
