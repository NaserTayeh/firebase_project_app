// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_firebase/Auth/auth_helper.dart';
import 'package:final_project_firebase/data_reposotries/fire_store_helper.dart';
import 'package:final_project_firebase/model/user_model.dart';
import 'package:final_project_firebase/router/app_router.dart';
import 'package:final_project_firebase/views/home/home2_screen.dart';
import 'package:final_project_firebase/views/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:string_validator/string_validator.dart';

import '../model/product_model.dart';

class MyProvider extends ChangeNotifier {
  bool visible = false;
  bool loginPassVisible = false;
  bool isEdit = true;
  bool isFavourite = false;
  String query = '';
  int currentPage = 0;
  int selectedIndexScreen = 0;
  bool isDarkMode = false;

  changeMode() {
    isDarkMode = !isDarkMode;
    notifyListeners();
  }

  late UserModel loggingUser;
  int quantity = 1;

  TextEditingController updatedFullName = TextEditingController();
  TextEditingController updatedEmail = TextEditingController();
  setIndex(int i) {
    selectedIndexScreen = i;
    notifyListeners();
  }

  changeCurrentPage(value) {
    currentPage = value;
    notifyListeners();
  }

  setQuery(value) {
    query = value;
    notifyListeners();
  }

  changeIsEdit(bool v) {
    isEdit = v;
    notifyListeners();
  }

  changeIsFavourite(bool v) {
    isFavourite = v;
    notifyListeners();
  }

  incrementQuantity() {
    quantity++;
    notifyListeners();
  }

  decrementQuantity() {
    quantity--;
    notifyListeners();
  }

  updateQuantity(String pId) {
    FireStoreHelper.fireStoreHelper.firestore
        .collection('cart')
        .doc(AuthHelper.authHelper.firebaseAuth.currentUser!.uid)
        .collection('userCart')
        .doc(pId)
        .update({'productQuantity': quantity});
  }

  deleteItemFromCart(String pId) {
    FireStoreHelper.fireStoreHelper.firestore
        .collection('cart')
        .doc(AuthHelper.authHelper.firebaseAuth.currentUser!.uid)
        .collection('userCart')
        .doc(pId)
        .delete();
  }

  changeLoginPassVisibility() {
    loginPassVisible = !loginPassVisible;
    notifyListeners();
  }

  changeVisibility() {
    visible = !visible;
    notifyListeners();
    // log(loggingUser.emailAddress);
  }

  Future getCurrentUserData() async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await FireStoreHelper.fireStoreHelper.firestore
            .collection('users')
            .doc(AuthHelper.authHelper.firebaseAuth.currentUser!.uid)
            .get();
    Map<String, dynamic>? data = documentSnapshot.data();

    if (documentSnapshot.exists) {
      loggingUser = UserModel.fromMap(data!);
      // return user;
    } else {
      print('documentSnapshot does not exsist in DB');
    }
  }

  Future buildUpdateProfile() async {
    loggingUser.emailAddress = updatedEmail.text;
    loggingUser.fullName = updatedFullName.text;
    log(loggingUser.toMap().toString());
    FireStoreHelper.fireStoreHelper.firestore
        .collection('users')
        .doc(AuthHelper.authHelper.firebaseAuth.currentUser!.uid)
        .update(loggingUser.toMap());
    AppRouter.appRouter.goToWidget(MyHome());
  }

  profileValidation(BuildContext context) async {
    if (updatedEmail.text.trim().isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Email Addressis empty')));
      return;
    } else if (!isEmail(updatedEmail.text)) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Invalid Email Addressis ')));
      return;
    } else if (updatedFullName.text.trim().isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(' full name empty')));
      return;
    } else {
      buildUpdateProfile();
    }
  }

  List<Product> allProduct = [];
  Future<List<Product>?> getAllProducts(String catId, coll, subColl) async {
    log('cat = ' + coll);
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FireStoreHelper
        .fireStoreHelper.firestore
        .collection(coll)
        .doc(catId)
        .collection(subColl)
        .get();
    allProduct = querySnapshot.docs.map((e) {
      Product product = Product.fromMap(e.data());
      product.id = e.id;
      return product;
    }).toList();
    log('lll = ' + allProduct.length.toString());
    notifyListeners();
  }
}
