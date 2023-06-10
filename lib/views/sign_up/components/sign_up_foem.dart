// ignore_for_file: prefer_const_constructors

import 'package:final_project_firebase/components/custom_button2.dart';
import 'package:final_project_firebase/router/app_router.dart';
import 'package:final_project_firebase/views/home/home2_screen.dart';
import 'package:final_project_firebase/views/login/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../../../Themes/app_colors.dart';
import '../../../components/custom_icon.dart';
import '../../../provider/my_provider.dart';
import '../../../provider/signup_auth_provider.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  String? conform_password;
  bool remember = false;
  final List<String?> errors = [];

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(28),
      borderSide: BorderSide(color: AppColors.kTextColor),
      gapPadding: 10,
    );
    double getWidth(value) {
      double screenWidth = MediaQuery.of(context).size.width;
      // 375 is the layout width that designer use
      return (value / 375.0) * screenWidth;
    }

    getheight(value) {
      num screenHight = MediaQuery.of(context).size.height;
      return (value / 812.0) * screenHight;
    }

    return Consumer2<SignupAuthProvider, MyProvider>(
      builder: (context, signupAuthProvider, myProvider, w) {
        return Column(
          children: [
            TextFormField(
              style: TextStyle(
                  color: Provider.of<MyProvider>(context).isDarkMode
                      ? Colors.white
                      : AppColors.kTextColor),
              controller: signupAuthProvider.fullName,
              decoration: InputDecoration(
                labelText: "User Name",
                hintText: "Full name",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 42, vertical: 20),
                enabledBorder: outlineInputBorder,
                focusedBorder: outlineInputBorder,
                border: outlineInputBorder,
              ),
            ),
            SizedBox(height: getheight(40)),
            TextFormField(
              style: TextStyle(
                  color: Provider.of<MyProvider>(context).isDarkMode
                      ? Colors.white
                      : AppColors.kTextColor),
              keyboardType: TextInputType.emailAddress,
              controller: signupAuthProvider.emailAddress,
              decoration: InputDecoration(
                labelText: "Email",
                hintText: "Email address",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 42, vertical: 20),
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
              controller: signupAuthProvider.password,
              obscureText: myProvider.visible,
              decoration: InputDecoration(
                labelText: "Password",
                hintText: "Password",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                suffixIcon: IconButton(
                    onPressed: () {
                      myProvider.changeVisibility();
                    },
                    icon: Container(
                      margin: EdgeInsets.only(right: 20),
                      child: Icon(
                        myProvider.visible
                            ? Icons.visibility_off
                            : Icons.visibility,
                        size: 30,
                      ),
                    )),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 42, vertical: 20),
                enabledBorder: outlineInputBorder,
                focusedBorder: outlineInputBorder,
                border: outlineInputBorder,
              ),
            ),
            SizedBox(height: getheight(30)),
            Column(
              children: [
                signupAuthProvider.loading == false
                    ? ButtonCusomized(
                        text: "Sign Up",
                        function: () {
                          signupAuthProvider.signupValidation(context);
                        },
                      )
                    : SpinKitWave(
                        color: Color.fromARGB(255, 25, 12, 163),
                        size: 50.0,
                      ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account?\t\t'),
                    GestureDetector(
                        onTap: () {
                          AppRouter.appRouter.goToWidget(SignInScreen());
                        },
                        child: Text(
                          'LOGIN',
                          style: TextStyle(color: AppColors.kPrimaryColor),
                        )),
                  ],
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
