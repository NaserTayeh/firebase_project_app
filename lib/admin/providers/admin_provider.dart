import 'dart:developer';
import 'dart:io';

import 'package:final_project_firebase/admin/models/category.dart';
import 'package:final_project_firebase/admin/models/product.dart';
import 'package:flutter/material.dart' hide Slider;
import 'package:image_picker/image_picker.dart';

import '../../data_reposotries/fire_store_helper.dart';
import '../../data_reposotries/storage_helper.dart';

import '../../router/app_router.dart';
import '../models/slider.dart';
import '../views/screens/edit_category.dart';

class AdminProviderc extends ChangeNotifier {
  AdminProviderc() {
    getAllCategories();

    getAllSliders();
  }
  String? requiredValidation(String? content) {
    if (content == null || content.isEmpty) {
      return "Required field";
    }
  }

  // add new category
  File? imageFile;
  TextEditingController catNameArController = TextEditingController();
  TextEditingController catNameEnController = TextEditingController();
  GlobalKey<FormState> categoryFormKey = GlobalKey<FormState>();
  pickImageForCategory() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      notifyListeners();
    }
  }

  addNewCategory() async {
    if (imageFile != null) {
      if (categoryFormKey.currentState!.validate()) {
        // add category process
        AppRouter.appRouter.showLoadingDialoug();
        String imageUrl = await StorageHelper.storageHelper
            .uploadNewImage("cats_images", imageFile!);
        Category category = Category(
            imageUrl: imageUrl,
            nameAr: catNameArController.text,
            nameEn: catNameEnController.text);

        String? id =
            await FireStoreHelper.fireStoreHelper.addNewCategory(category);

        AppRouter.appRouter.hideDialoug();
        if (id != null) {
          category.id = id;
          allCategories!.add(category);
          notifyListeners();
          catNameArController.clear();
          catNameEnController.clear();
          imageFile = null;
          notifyListeners();
          AppRouter.appRouter
              .showCustomDialoug('Success', 'Your category has been added');
        }
      }
    } else {
      AppRouter.appRouter
          .showCustomDialoug('Error', 'You have to pick image first');
    }
  }

  // get cateogies
  List<Category>? allCategories;
  List<Product>? allProducts;
  List<Slider>? allSliders;
  getAllCategories() async {
    allCategories = await FireStoreHelper.fireStoreHelper.getAllCategories();
    notifyListeners();
  }

  // delete category
  deleteCategory(Category category) async {
    AppRouter.appRouter.showLoadingDialoug();
    bool deleteSuccess =
        await FireStoreHelper.fireStoreHelper.deleteCategoey(category.id!);
    if (deleteSuccess) {
      allCategories!.remove(category);
      notifyListeners();
    }
    AppRouter.appRouter.hideDialoug();
  }

  goToEditCategoryPage(Category category) {
    catNameArController.text = category.nameAr;
    // catNameEnController.text = category.nameEn;
    log('as');
    AppRouter.appRouter.goToWidget(EditCategory(category));
  }

  updateCategory(Category category) async {
    AppRouter.appRouter.showLoadingDialoug();
    if (imageFile != null) {
      String imageUrl = await StorageHelper.storageHelper
          .uploadNewImage("cats_images", imageFile!);
      category.imageUrl = imageUrl;
    }
    Category newCategory = Category(
        id: category.id,
        imageUrl: category.imageUrl,
        nameAr: catNameArController.text.isEmpty
            ? category.nameAr
            : catNameArController.text,
        nameEn: catNameEnController.text.isEmpty
            ? category.nameEn
            : catNameEnController.text);

    bool? isUpdated =
        await FireStoreHelper.fireStoreHelper.updateCategory(newCategory);

    if (isUpdated != null && isUpdated) {
      int index = allCategories!.indexOf(category);
      allCategories![index] = newCategory;
      imageFile = null;
      catNameEnController.clear();
      catNameArController.clear();
      notifyListeners();
      AppRouter.appRouter.hideDialoug();
      AppRouter.appRouter.hideDialoug();
    }
  }

  TextEditingController sliderTitleController = TextEditingController();
  TextEditingController sliderUrlController = TextEditingController();
  TextEditingController productNameController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  GlobalKey<FormState> addProductKey = GlobalKey();
  addNewProduct(String catId) async {
    // if (imageFile != null) {
    //   if (addProductKey.currentState!.validate()) {
    //     AppRouter.appRouter.showLoadingDialoug();
    //     String imageUrl = await StorageHelper.storageHelper
    //         .uploadNewImage("products_images", imageFile!);
    //     Product product = Product(
    //         image: imageUrl,
    //         name: productNameController.text,
    //         description: productDescriptionController.text,
    //         price: num.parse(productPriceController.text),
    //         catId: catId);

    //     String? id =
    //         await FireStoreHelper.fireStoreHelper.addNewProduct(product);

    //     AppRouter.appRouter.hideDialoug();
    //     if (id != null) {
    //       product.id = id;
    //       allProducts?.add(product);
    //       notifyListeners();
    //       productNameController.clear();
    //       productDescriptionController.clear();
    //       productPriceController.clear();
    //       imageFile = null;
    //       notifyListeners();
    //       AppRouter.appRouter
    //           .showCustomDialoug('Success', 'Your Product has been added');
    //     }
    //   }
    // } else {
    //   AppRouter.appRouter
    //       .showCustomDialoug('Error', 'You have to pick image first');
    // }
  }

  getAllProducts(String catId, collection, subCollection) async {
    allProducts = null;
    notifyListeners();
    List<Product>? products = await FireStoreHelper.fireStoreHelper
        .getAllProducts(catId, collection, subCollection);

    allProducts = products;
    allProducts!.forEach((element) {
      log(element.name);
    });
    notifyListeners();
  }

  getAllSliders() async {
    allSliders = await FireStoreHelper.fireStoreHelper.getAllSliders();
  }

  AddNewSlider() async {
    if (imageFile != null) {
      AppRouter.appRouter.showLoadingDialoug();
      String imageUrl = await StorageHelper.storageHelper
          .uploadNewImage("Slider_images", imageFile!);
      Slider slider = Slider(
          imageUrl: imageUrl,
          title: sliderTitleController.text,
          url: sliderUrlController.text);

      String? id = await FireStoreHelper.fireStoreHelper.addNewSlider(slider);

      AppRouter.appRouter.hideDialoug();
      if (id != null) {
        slider.id = id;
        allSliders?.add(slider);
        notifyListeners();
        sliderTitleController.clear();
        sliderUrlController.clear();

        imageFile = null;
        notifyListeners();
        AppRouter.appRouter
            .showCustomDialoug('Success', 'Your Slider has been added');
      }
    } else {
      AppRouter.appRouter
          .showCustomDialoug('Error', 'You have to pick image first');
    }
  }
  // update category
//   updateCategory()async{
//     FirestoreHelper.firestoreHelper.updateCategory(category)
//   }
}
