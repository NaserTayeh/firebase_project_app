// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:final_project_firebase/provider/my_provider.dart';
import 'package:final_project_firebase/views/favorite/favorite_screen.dart';
import 'package:final_project_firebase/views/home/components/bottom_nav.dart';
import 'package:final_project_firebase/views/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../Themes/app_colors.dart';
import 'components/home_body.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeBody(),
    );
  }
}

class MyHome extends StatelessWidget {
  PageController pageController = PageController();
  List<Widget> pages = [HomePage(), FavoriteScreen(), ProfilePage()];

  @override
  Widget build(BuildContext context) {
    onPageChanged(int i) {
      Provider.of<MyProvider>(context, listen: false).setIndex(i);
    }

    oneItemTap(int selectedI) {
      pageController.jumpToPage(selectedI);
    }

    return Scaffold(
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
        child: BottomNavigationBar(
            backgroundColor: Provider.of<MyProvider>(context).isDarkMode
                ? Color.fromARGB(30, 0, 0, 0)
                : AppColors.kwhiteColor.withOpacity(0.8),
            onTap: oneItemTap,
            iconSize: 35,
            items: [
              BottomNavigationBarItem(
                label: '',
                icon: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: SvgPicture.asset(
                      "assets/icons/Shop Icon.svg",
                      width: 23,
                      height: 23,
                      color: Provider.of<MyProvider>(context)
                                  .selectedIndexScreen ==
                              0
                          ? AppColors.kPrimaryColor
                          : AppColors.kSecondaryColor,
                    )),
              ),
              BottomNavigationBarItem(
                  label: '',
                  icon: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: SvgPicture.asset(
                        "assets/icons/favoriteiv.svg",
                        width: 23,
                        height: 23,
                        color: Provider.of<MyProvider>(context)
                                    .selectedIndexScreen ==
                                1
                            ? AppColors.kPrimaryColor
                            : AppColors.kSecondaryColor,
                      ))),
              BottomNavigationBarItem(
                  label: '',
                  icon: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: SvgPicture.asset(
                        "assets/icons/User.svg",
                        width: 23,
                        height: 23,
                        color: Provider.of<MyProvider>(context)
                                    .selectedIndexScreen ==
                                2
                            ? AppColors.kPrimaryColor
                            : AppColors.kSecondaryColor,
                      ))),
            ]),
      ),
      body: PageView(
        controller: pageController,
        children: pages,
        onPageChanged: onPageChanged,
      ),
    );
  }
}
