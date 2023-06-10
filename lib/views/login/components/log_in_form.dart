// ignore_for_file: curly_braces_in_flow_control_structures, prefer_const_constructors

import 'package:final_project_firebase/Themes/app_colors.dart';
import 'package:final_project_firebase/components/custom_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/custom_button.dart';
import '../../../components/custom_icon.dart';
import '../../../provider/login_auth_provider.dart';
import '../../../provider/my_provider.dart';

class SignForm extends StatelessWidget {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(28),
    borderSide: BorderSide(color: AppColors.kTextColor),
    gapPadding: 10,
  );

  @override
  Widget build(BuildContext context) {
    getheight(value) {
      num screenHight = MediaQuery.of(context).size.height;
      return (value / 812.0) * screenHight;
    }

    return Consumer2<LoginAuthProvider, MyProvider>(
      builder: (context, provider, myProvider, w) {
        return Column(
          children: [
            TextFormField(
              style: TextStyle(
                  color: Provider.of<MyProvider>(context).isDarkMode
                      ? Colors.white
                      : AppColors.kTextColor),
              keyboardType: TextInputType.emailAddress,
              controller: provider.loginEmail,
              decoration: InputDecoration(
                labelText: "Email",
                hintText: "Enter your email",
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 42, vertical: 20),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
                enabledBorder: outlineInputBorder,
                focusedBorder: outlineInputBorder,
                border: outlineInputBorder,
              ),
            ),
            SizedBox(height: getheight(30)),
            TextFormField(
              style: TextStyle(
                  color: Provider.of<MyProvider>(context).isDarkMode
                      ? Colors.white
                      : AppColors.kTextColor),
              obscureText: myProvider.loginPassVisible,
              controller: provider.loginPassword,
              decoration: InputDecoration(
                labelText: "Password",
                hintText: "Enter your password",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                suffixIcon: IconButton(
                    onPressed: () {
                      myProvider.changeLoginPassVisibility();
                    },
                    icon: Icon(
                      myProvider.loginPassVisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                      size: 28,
                    )),
                enabledBorder: outlineInputBorder,
                focusedBorder: outlineInputBorder,
                border: outlineInputBorder,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 42, vertical: 20),
              ),
            ),
            SizedBox(height: getheight(30)),
            Row(
              children: [],
            ),
            SizedBox(height: getheight(20)),
            provider.loading
                ? CircularProgressIndicator()
                : ButtonCusomized(
                    function: () {
                      provider.loginValidation(context);
                    },
                    text: 'LOG IN')
          ],
        );
      },
    );
  }
}
