// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';

import '../../../router/app_router.dart';
import 'all_sliders_screen.dart';
import 'display_categories.dart';

class MainAdminScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              Expanded(
                  child: InkWell(
                onTap: () {
                  AppRouter.appRouter.goToWidget(AllCategoriesScreen());
                },
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Text(
                    'Go To Categories',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.grey),
                ),
              )),
              SizedBox(
                height: 20,
              ),
              Expanded(
                  child: InkWell(
                onTap: () {
                  AppRouter.appRouter.goToWidget(AllSliderScreen());
                },
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Text(
                    'Go To Sliders',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.grey),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
