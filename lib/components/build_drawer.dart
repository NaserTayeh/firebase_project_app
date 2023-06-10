// ignore_for_file: prefer_const_constructors

import 'package:final_project_firebase/provider/my_provider.dart';
import 'package:final_project_firebase/views/cart/cart_screen.dart';
import 'package:final_project_firebase/views/favorite/favorite_screen.dart';
import 'package:final_project_firebase/views/profile/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../router/app_router.dart';
import '../views/login/login_screen.dart';

class BuildDrawer extends StatelessWidget {
  const BuildDrawer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Provider.of<MyProvider>(context).getCurrentUserData();
    return Consumer<MyProvider>(
      builder: (context, provider, w) {
        provider.getCurrentUserData();
        return Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: Colors.purple),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://st3.depositphotos.com/4111759/13425/v/600/depositphotos_134255710-stock-illustration-avatar-vector-male-profile-gray.jpg'),
                  ),
                  accountName: Text(provider.loggingUser.fullName),
                  accountEmail: Text(provider.loggingUser.emailAddress)),
              ListTile(
                onTap: () {
                  AppRouter.appRouter.goToWidget(ProfileScreen());
                },
                leading: Icon(Icons.person),
                title: Text('Profile'),
              ),
              ListTile(
                onTap: () {
                  AppRouter.appRouter.goToWidget(CartScreen());
                },
                leading: Icon(Icons.shopping_cart_checkout_rounded),
                title: Text('cart'),
              ),
              ListTile(
                onTap: () {
                  AppRouter.appRouter.goToWidget(FavoriteScreen());
                },
                leading: Icon(Icons.favorite),
                title: Text('Favorite'),
              ),
              InkWell(
                onTap: () {},
                child: ListTile(
                  leading: Icon(Icons.shopping_basket_sharp),
                  title: Text('My Order'),
                ),
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                onTap: () {
                  FirebaseAuth.instance.signOut().then(
                      (value) => AppRouter.appRouter.goToWidget(LoginScreen()));
                },
                title: Text('Log Out'),
              ),
            ],
          ),
        );
      },
    );
  }
}
