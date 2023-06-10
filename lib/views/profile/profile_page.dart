import 'package:flutter/material.dart';

import '../home/components/bottom_nav.dart';
import 'components/profile_body.dart';

class ProfilePage extends StatelessWidget {
  static String routeName = "/profile";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: ProfileBody(),
      // bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile),
    );
  }
}
