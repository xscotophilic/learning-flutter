import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import './components/body.dart';
import '../add_place/add_place_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
              },
              icon: Icon(Icons.add),
            )
          ],
        ),
        body: Center(
          child: Body(),
        ),
      ),
    );
  }
}
