import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_firebase/provider/my_provider.dart';
import 'package:final_project_firebase/router/app_router.dart';
import 'package:final_project_firebase/views/cart/cart_page.dart';
import 'package:final_project_firebase/views/home/components/search_field.dart';
import 'package:final_project_firebase/views/profile/profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/icon_button_with_noti.dart';
import '../../../model/user_model.dart';

late UserModel userModel;

Size? size;

class HomeHeader extends StatefulWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  String query = "";
  var result;
  searchFunction(query, searchList) {
    result = searchList.where((element) {
      return element["productName"].toUpperCase().contains(query) ||
          element["productName"].toLowerCase().contains(query) ||
          element["productName"].toUpperCase().contains(query) &&
              element["productName"].toLowerCase().contains(query);
    }).toList();
    return result;
  }

  Future getCurrentUserDataFunction() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then(
      (DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          userModel = UserModel.fromMap(documentSnapshot);
        } else {
          print("Document does not exist the database");
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double getWidth(value) {
      double screenWidth = MediaQuery.of(context).size.width;
      return (value / 375.0) * screenWidth;
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SearchPart(),
          IconButtonCounter(
            svgSrc: 'assets/icons/Cart Icon.svg',
            numOfItems: 0,
            press: () {
              AppRouter.appRouter.goToWidget(CartPage());
            },
          ),
          IconButtonCounter(
            svgSrc: Provider.of<MyProvider>(context).isDarkMode
                ? 'assets/icons/light.svg'
                : 'assets/icons/dark.svg',
            numOfItems: 0,
            press: () {
              Provider.of<MyProvider>(context, listen: false).changeMode();
            },
          ),
        ],
      ),
    );
  }
}
