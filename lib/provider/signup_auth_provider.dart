// ignore_for_file: prefer_const_constructors

import 'dart:developer';
import 'package:final_project_firebase/Auth/auth_helper.dart';
import 'package:final_project_firebase/model/user_model.dart';
import 'package:final_project_firebase/router/app_router.dart';
import 'package:final_project_firebase/views/home/home2_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:string_validator/string_validator.dart';

import '../data_reposotries/fire_store_helper.dart';
import '../views/home/home_screen.dart';

class SignupAuthProvider extends ChangeNotifier {
  TextEditingController fullName = TextEditingController();
  TextEditingController emailAddress = TextEditingController();
  TextEditingController password = TextEditingController();
  bool loading = false;

  signupValidation(BuildContext context) async {
    if (fullName.text.trim().isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Full name is empty')));
      return;
    } else if (emailAddress.text.trim().isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Email Addressis empty')));
      return;
    } else if (!isEmail(emailAddress.text)) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Invalid Email Addressis ')));
      return;
    } else if (password.text.trim().isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(' password empty')));
      return;
    } else if (password.text.length < 8) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(' password must be 8 or more')));
      return;
    } else {
      try {
        loading = true;
        notifyListeners();
        String? result = await AuthHelper.authHelper
            .signUp(emailAddress.text, password.text);
        loading = true;
        notifyListeners();
        if (result != null) {
          FireStoreHelper.fireStoreHelper.addNewUSer(UserModel(
              fullName: fullName.text,
              emailAddress: emailAddress.text,
              password: password.text,
              userId: result));
          loading = false;
          notifyListeners();

          // AppRouter.appRouter.goToWidget(HomeScreen());
          AppRouter.appRouter.goToWidgetAndReplace(MyHome());
        }
      } on FirebaseAuthException catch (e) {
        loading = false;
        notifyListeners();
        if (e.code == "weak-password") {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('weak-password')));
        } else if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('email-already-in-use')));
        }
        // TODO
      }
    }
  }
}
