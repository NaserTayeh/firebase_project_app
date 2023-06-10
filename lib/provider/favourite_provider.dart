import 'package:final_project_firebase/Auth/auth_helper.dart';
import 'package:final_project_firebase/data_reposotries/fire_store_helper.dart';
import 'package:flutter/cupertino.dart';

class FavouriteProvider extends ChangeNotifier {
  favouriteFunction({
    required productId,
    required productCategory,
    required productRate,
    required productOldPrice,
    required productPrice,
    required productImage,
    required productFavorite,
    required productName,
    required productDescription,
  }) {
    FireStoreHelper.fireStoreHelper.firestore
        .collection('favorite')
        .doc(AuthHelper.authHelper.firebaseAuth.currentUser!.uid)
        .collection('userFavorite')
        .doc(productId)
        .set({
      'productId': productId,
      'productCategory': productCategory,
      'productRate': productRate,
      'productOldPrice': productOldPrice,
      'productPrice': productPrice,
      'productImage': productImage,
      'productFavorite': productFavorite,
      'productName': productName,
      'productDescription': productDescription,
    });
    notifyListeners();
  }

  removeFavourite({
    required productId,
  }) {
    FireStoreHelper.fireStoreHelper.firestore
        .collection('favorite')
        .doc(AuthHelper.authHelper.firebaseAuth.currentUser!.uid)
        .collection('userFavorite')
        .doc(productId)
        .delete();
    notifyListeners();
  }
}
