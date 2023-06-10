// ignore_for_file: prefer_const_constructors

import 'package:final_project_firebase/Themes/app_colors.dart';
import 'package:final_project_firebase/admin/views/screens/main_admin_screen.dart';
import 'package:final_project_firebase/provider/admin_provider.dart';
import 'package:final_project_firebase/provider/cart_provider.dart';
import 'package:final_project_firebase/provider/favourite_provider.dart';
import 'package:final_project_firebase/provider/login_auth_provider.dart';
import 'package:final_project_firebase/provider/signup_auth_provider.dart';
import 'package:final_project_firebase/router/app_router.dart';
import 'package:final_project_firebase/views/home/home2_screen.dart';
import 'package:final_project_firebase/views/home/home_screen.dart';
import 'package:final_project_firebase/views/sign_up/sign_up_page.dart';
import 'package:final_project_firebase/views/sign_up/sign_up_screen.dart';
import 'package:final_project_firebase/views/welcome/splach_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'admin/providers/admin_provider.dart';
import 'firebase_options.dart';
import 'provider/my_provider.dart';
import 'views/welcome/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MyProvider>(
          create: (context) {
            return MyProvider();
          },
        ),
        ChangeNotifierProvider<SignupAuthProvider>(
          create: (context) {
            return SignupAuthProvider();
          },
        ),
        ChangeNotifierProvider<LoginAuthProvider>(
          create: (context) {
            return LoginAuthProvider();
          },
        ),
        ChangeNotifierProvider<AdminProvider>(
          create: (context) {
            return AdminProvider();
          },
        ),
        ChangeNotifierProvider<AdminProviderc>(
          create: (context) {
            return AdminProviderc();
          },
        ),
        ChangeNotifierProvider<CartProvider>(
          create: (context) {
            return CartProvider();
          },
        ),
        ChangeNotifierProvider<FavouriteProvider>(
          create: (context) {
            return FavouriteProvider();
          },
        ),
      ],
      child: MyApplication(),
    );
  }
}

class MyApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(
        fontFamily: 'Muli',
      ),
      child: MaterialApp(
        navigatorKey: AppRouter.appRouter.navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: Provider.of<MyProvider>(context).isDarkMode
            ? ThemeData.dark().copyWith(
                // appBarTheme: AppBarTheme(
                //     textTheme: TextTheme(
                //         headline6: TextStyle(
                //             fontSize: 18,
                //             color: Color.fromARGB(255, 145, 10, 10))),
                //     // color: Colors.white,
                //     elevation: 0,
                //     brightness: Brightness.light,
                //     iconTheme: IconThemeData(color: Colors.black)),
                // visualDensity: VisualDensity.adaptivePlatformDensity,
                // textTheme: TextTheme(
                //   bodyText1: TextStyle(
                //     color: AppColors.kTextColor,
                //   ),
                //   bodyText2: TextStyle(color: AppColors.kTextColor),
                // ),
                )
            : ThemeData.light().copyWith(
                appBarTheme: AppBarTheme(
                    textTheme: TextTheme(
                        headline6: TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 145, 10, 10))),
                    color: Colors.transparent,
                    elevation: 0,
                    brightness: Brightness.light,
                    iconTheme: IconThemeData(color: Colors.black)),
                visualDensity: VisualDensity.adaptivePlatformDensity,
                textTheme: TextTheme(
                  bodyText1: TextStyle(
                    color: AppColors.kTextColor,
                  ),
                  bodyText2: TextStyle(color: AppColors.kTextColor),
                ),
              ),
        home:
            // HomeScreen()
            // SignUpPage()
            // SplashScreen(),
            StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, userSnapshot) {
            if (userSnapshot.hasData) {
              return MyHome();
            } else {
              return SplashScreen();
            }
          },
        ),
      ),
    );
  }
}
