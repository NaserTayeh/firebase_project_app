import 'package:final_project_firebase/Auth/auth_helper.dart';
import 'package:flutter/material.dart';

import '../../components/grid_view.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GridViewWidget(
      subCollection: 'userFavorite',
      collection: 'favorite',
      id: AuthHelper.authHelper.firebaseAuth.currentUser!.uid,
    );
  }
}
