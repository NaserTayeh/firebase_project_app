// ignore_for_file: use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:final_project_firebase/components/custom_button.dart';
import 'package:final_project_firebase/provider/my_provider.dart';
import 'package:final_project_firebase/provider/signup_auth_provider.dart';
import 'package:final_project_firebase/router/app_router.dart';
import 'package:final_project_firebase/views/login/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Consumer2<SignupAuthProvider, MyProvider>(
        builder: (context, signupAuthProvider, myProvider, w) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Sign Up',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Column(
                children: [
                  TextFormField(
                    controller: signupAuthProvider.fullName,
                    decoration: InputDecoration(
                      hintText: " Full name",
                    ),
                  ),
                  TextFormField(
                    controller: signupAuthProvider.emailAddress,
                    decoration: InputDecoration(
                      hintText: " Email address",
                    ),
                  ),
                  TextFormField(
                    controller: signupAuthProvider.password,
                    obscureText: Provider.of<MyProvider>(context).visible,
                    decoration: InputDecoration(
                        hintText: " Password",
                        suffixIcon: IconButton(
                            onPressed: () {
                              myProvider.changeVisibility();
                            },
                            icon: Icon(myProvider.visible
                                ? Icons.visibility_off
                                : Icons.visibility))),
                  ),
                ],
              ),
              Column(
                children: [
                  signupAuthProvider.loading == false
                      ? CustomButton(
                          function: () {
                            signupAuthProvider.signupValidation(context);
                          },
                          text: "SIGN UP")
                      : SpinKitWave(
                          color: Color.fromARGB(255, 25, 12, 163),
                          size: 50.0,
                        ),
                  // CircularProgressIndicator(),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account?\t\t'),
                      GestureDetector(
                          onTap: () {
                            AppRouter.appRouter.goToWidget(LoginScreen());
                          },
                          child: Text('LOGIN')),
                    ],
                  ),
                ],
              )
            ],
          );
        },
      ),
    )));
  }
}
