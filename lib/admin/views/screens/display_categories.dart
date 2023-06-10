// ignore_for_file: prefer_const_constructors

// import 'package:final_project_firebase/admin/views/components/category_widget.dart';
import 'package:final_project_firebase/admin/views/components/category_widget.dart';
import 'package:final_project_firebase/admin/views/screens/add_category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../router/app_router.dart';
import '../../providers/admin_provider.dart';

class AllCategoriesScreen extends StatelessWidget {
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
        title: Text('All Categories'),
      ),
      body: Consumer<AdminProviderc>(builder: (context, provider, w) {
        return provider.allCategories == null
            ? Center(
                child: Text('No Categories Found'),
              )
            : ListView.builder(
                itemCount: provider.allCategories!.length,
                itemBuilder: (context, index) {
                  return CategoryWidget(provider.allCategories![index]);
                });
      }),
    );
  }
}
