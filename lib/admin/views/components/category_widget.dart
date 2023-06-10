import 'dart:developer';

import 'package:final_project_firebase/admin/models/category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/admin_provider.dart';
import '../../../router/app_router.dart';
import '../../providers/admin_provider.dart';
import '../screens/display_products.dart';

class CategoryWidget extends StatelessWidget {
  Category category;
  CategoryWidget(this.category);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      onTap: () {
        Provider.of<AdminProviderc>(context, listen: false)
            .getAllProducts(category.id!, 'categories', category.nameAr);
        AppRouter.appRouter.goToWidget(AllProductsScreen());
      },
      child: Container(
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.black, width: 2)),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(13)),
                  child: SizedBox(
                      width: double.infinity,
                      height: 170,
                      child: Image.network(
                        category.imageUrl,
                        fit: BoxFit.cover,
                      )),
                ),
                Positioned(
                    right: 15,
                    top: 10,
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.white,
                          child: IconButton(
                              onPressed: () {
                                Provider.of<AdminProviderc>(context,
                                        listen: false)
                                    .deleteCategory(category);
                              },
                              icon: Icon(Icons.delete)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.white,
                          child: IconButton(
                              onPressed: () {
                                Provider.of<AdminProviderc>(context,
                                        listen: false)
                                    .goToEditCategoryPage(category);
                              },
                              icon: Icon(Icons.edit)),
                        ),
                      ],
                    ))
              ],
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Arabic Category' + ': ' + category.nameAr,
                    ),
                    // Text(
                    //   'English Category' + ': ' + category.nameEn,
                    // ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
