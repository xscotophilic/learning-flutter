import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import './components/body.dart';

class AddPlaceScreen extends StatelessWidget {
  static const routeName = '/add-place';

  const AddPlaceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          leading: Builder(
            builder: (context) => IconButton(
              icon: SvgPicture.asset(
                "assets/icons/menu.svg",
                color: Theme.of(context).accentColor,
                width: 20,
              ),
              onPressed: () => {},
              // onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          title: Image.asset(
            "assets/icons/logo.png",
            height: 30,
          ),
        ),
        body: Center(
          child: Body(),
        ),
      ),
    );
  }
}
