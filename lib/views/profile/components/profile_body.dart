import 'package:final_project_firebase/views/cart/cart_page.dart';
import 'package:final_project_firebase/views/checkout/checkout_screen.dart';
import 'package:final_project_firebase/views/login/sign_in_screen.dart';
import 'package:final_project_firebase/views/profile/components/profile_menu.dart';
import 'package:final_project_firebase/views/profile/components/profile_pic.dart';
import 'package:final_project_firebase/views/profile/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/my_provider.dart';
import '../../../router/app_router.dart';
import '../../login/login_screen.dart';

class ProfileBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<MyProvider>(context).getCurrentUserData();

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(),
          SizedBox(height: 20),
          ProfileMenu(
            text: "My Account",
            icon: "assets/icons/User Icon.svg",
            press: () => {AppRouter.appRouter.goToWidget(ProfileScreen())},
          ),
          ProfileMenu(
            text: "Cart",
            icon: "assets/icons/Cart Icon.svg",
            press: () {
              AppRouter.appRouter.goToWidget(CartPage());
            },
          ),
          ProfileMenu(
            text: "Orders",
            icon: "assets/icons/order.svg",
            press: () {
              AppRouter.appRouter.goToWidget(CheckoutScreen());
            },
          ),
          ProfileMenu(
            text: "Log Out",
            icon: "assets/icons/Log out.svg",
            press: () {
              FirebaseAuth.instance.signOut().then(
                  (value) => AppRouter.appRouter.goToWidget(SignInScreen()));
            },
          ),
        ],
      ),
    );
  }
}
