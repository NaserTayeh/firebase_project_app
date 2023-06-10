import 'dart:developer';

import 'package:final_project_firebase/admin/views/components/product_widget.dart';
import 'package:final_project_firebase/admin/views/screens/add_category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/admin_provider.dart';
import '../../../router/app_router.dart';
import '../../providers/admin_provider.dart';

class AllProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                AppRouter.appRouter.goToWidget(AddNewCategory());
              },
              icon: Icon(Icons.add))
        ],
        title: Text('All Products'),
      ),
      body: Consumer<AdminProviderc>(builder: (context, provider, w) {
        return provider.allProducts == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: provider.allProducts!.length,
                itemBuilder: (context, index) {
                  return ProductWidget(provider.allProducts![index]
                      // productName: provider.allProducts![index].name,
                      // productPrice: provider.allProducts![index].price,
                      // productOldPrice: provider.allProducts![index].price,
                      // productRate: provider.allProducts![index].rate,
                      // productCategory: provider.allProducts![index].catId,
                      // productDescription:
                      //     provider.allProducts![index].description,
                      // productId: provider.allProducts![index].id,
                      // productImage: provider.allProducts![index].imageUrl,
                      // onTap: () {},
                      );
                });
      }),
    );
  }
}
