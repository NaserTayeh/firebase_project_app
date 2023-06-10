import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_firebase/Auth/auth_helper.dart';
import 'package:final_project_firebase/data_reposotries/fire_store_helper.dart';
import 'package:final_project_firebase/model/cart_model.dart';
import 'package:flutter/widgets.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class CartProvider extends ChangeNotifier {
  List<CartModel> cartList = [];
  CartModel? cartModel;
  getCartData() async {
    List<CartModel> newCartList = [];
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FireStoreHelper
        .fireStoreHelper.firestore
        .collection('cart')
        .doc(AuthHelper.authHelper.firebaseAuth.currentUser!.uid)
        .collection('userCart')
        .get();
    querySnapshot.docs.forEach((element) {
      cartModel = CartModel.fromMap(element.data());
      notifyListeners();
      newCartList.add(cartModel!);
    });
    cartList = newCartList;
    notifyListeners();
  }

  List<CartModel> getCartList() {
    return cartList;
  }

  calcTotal() {
    num calcTotal = 0.0;
    cartList.forEach((element) {
      calcTotal += element.productPrice * element.productQuantity;
    });
    return calcTotal;
  }
}
