// ignore_for_file: body_might_complete_normally_nullable

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_firebase/admin/models/category.dart';
import 'package:final_project_firebase/model/user_model.dart';

import '../admin/models/product.dart';
import '../admin/models/slider.dart';
import '../model/category_model.dart';

class FireStoreHelper {
  FireStoreHelper._();
  static FireStoreHelper fireStoreHelper = FireStoreHelper._();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  addNewUSer(UserModel appUser) async {
    firestore.collection('users').doc(appUser.userId).set(appUser.toMap());
  }

  Future<List<Category>?> getAllCategories() async {
    try {
      QuerySnapshot<Map<String, dynamic>> catsSnapshot =
          await firestore.collection('categories').get();
      List<Category> categories = catsSnapshot.docs.map((doc) {
        Category category = Category.fromMap(doc.data());
        category.id = doc.id;
        return category;
      }).toList();
      return categories;
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future<List<CategoryModel>?> getAllCategoriesModel() async {
    try {
      QuerySnapshot<Map<String, dynamic>> catsSnapshot =
          await firestore.collection('categories').get();
      List<CategoryModel> categories = catsSnapshot.docs.map((doc) {
        CategoryModel category = CategoryModel.fromMap(doc.data());
        category.id = doc.id;
        return category;
      }).toList();
      return categories;
    } on Exception catch (e) {
      log(e.toString());
    }
  }
  // Future<List<Category>?> getAllCategories() async {
  //   try {
  //     QuerySnapshot<Map<String, dynamic>> catsSnapshot =
  //         await firestore.collection('categories').get();
  //     List<Category> categories = catsSnapshot.docs.map((doc) {
  //       Category category = Category.fromMap(doc.data());
  //       category.id = doc.id;
  //       return category;
  //     }).toList();
  //     return categories;
  //   } on Exception catch (e) {
  //     log(e.toString());
  //   }
  // }

  // Future<AppUser> getUserFromFirestore(String id) async {
  //   DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
  //       await firestore.collection('USERSS').doc(id).get();
  //   Map<String, dynamic>? data = documentSnapshot.data();
  //   AppUser appUser = AppUser.fromMap(data!);
  //   return appUser;
  // }
  //// admin methods
  Future<String?> addNewCategory(Category category) async {
    try {
      DocumentReference<Map<String, dynamic>> categoryDocument =
          await firestore.collection('categories').add(category.toMap());

      return categoryDocument.id;
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future<bool> deleteCategoey(String catId) async {
    try {
      await firestore.collection('categories').doc(catId).delete();
      return true;
    } on Exception catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<bool?> updateCategory(Category category) async {
    try {
      await firestore
          .collection('categories')
          .doc(category.id)
          .update(category.toMap());
      return true;
    } on Exception catch (e) {
      log(e.toString());
      return false;
    }
  }

  /// products functions
  Future<String?> addNewProduct(Product product) async {
    try {
      DocumentReference<Map<String, dynamic>> documentReference =
          await firestore
              .collection('categories')
              .doc(product.catId)
              .collection('products')
              .add(product.toMap());
      return documentReference.id;
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future<List<Product>?> getAllProducts(
      String catId, collection, subcollection) async {
    log(catId + collection + subcollection);
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestore
        .collection(collection)
        .doc(catId)
        .collection(subcollection)
        .get();
    log('sss');
    return querySnapshot.docs.map((e) {
      Product product = Product.fromMap(e.data());
      product.id = e.id;
      log(product.name);
      return product;
    }).toList();
  }

  Future<bool?> deleteProduct(Product product) async {}
  Future<bool?> updateProduct(Product product) async {}
  Future<String?> addNewSlider(Slider slider) async {
    try {
      DocumentReference<Map<String, dynamic>> documentReference =
          await firestore.collection('sliders').add(slider.toMap());
      return documentReference.id;
    } on Exception catch (e) {
      return null;
    }
  }

  Future<List<Slider>?> getAllSliders() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await firestore.collection('sliders').get();
    return querySnapshot.docs.map((e) {
      Slider slider = Slider.fromMap(e.data());
      slider.id = e.id;
      return slider;
    }).toList();
  }
}
