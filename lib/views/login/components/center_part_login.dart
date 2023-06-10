// ignore_for_file: prefer_const_constructors

import 'package:final_project_firebase/provider/login_auth_provider.dart';
import 'package:final_project_firebase/provider/my_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class CenterPartLogin extends StatelessWidget {
  const CenterPartLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<LoginAuthProvider, MyProvider>(
      builder: (context, provider, myProvider, w) {
        return Column(
          children: [
            TextFormField(
              controller: provider.loginEmail,
              decoration: InputDecoration(
                hintText: " Email ",
              ),
            ),
            TextFormField(
                controller: provider.loginPassword,
                obscureText: myProvider.loginPassVisible,
                decoration: InputDecoration(
                    hintText: " Password",
                    suffixIcon: IconButton(
                        onPressed: () {
                          myProvider.changeLoginPassVisibility();
                        },
                        icon: Icon(myProvider.loginPassVisible
                            ? Icons.visibility_off
                            : Icons.visibility)))),
          ],
        );
      },
    );
  }
}
