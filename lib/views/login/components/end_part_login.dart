// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:final_project_firebase/provider/login_auth_provider.dart';
import 'package:final_project_firebase/router/app_router.dart';
import 'package:final_project_firebase/views/sign_up/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/custom_button.dart';

class EndPartLogin extends StatelessWidget {
  const EndPartLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginAuthProvider>(
      builder: (context, provider, w) {
        return Column(
          children: [
            provider.loading
                ? CircularProgressIndicator()
                : CustomButton(
                    function: () {
                      provider.loginValidation(context);
                    },
                    text: 'LOG IN'),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?\t\t"),
                GestureDetector(
                    onTap: () {
                      AppRouter.appRouter.goToWidget(SignupScreen());
                    },
                    child: Text('SIGN UP')),
              ],
            ),
          ],
        );
      },
    );
  }
}
