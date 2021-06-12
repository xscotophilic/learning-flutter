import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:appetite_assorted/const.dart';
import 'package:appetite_assorted/widgets/categories_home/all_categories_screen.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: CategoriesScreen(),
      // bottomNavigationBar: BottomNavBar(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset(
          "assets/icons/menu.svg",
          color: Constants.lightAccent,
        ),
        onPressed: () {},
      ),
    );
  }
}
