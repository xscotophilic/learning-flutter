import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import './components/body.dart';

class HomeScreen extends StatefulWidget {
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
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: buildAppBar(context),
          body: Center(
            child: Body(),
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      leading: Builder(
        builder: (context) => IconButton(
          icon: SvgPicture.asset(
            "assets/icons/menu.svg",
            color: Theme.of(context).accentColor,
            width: 20,
          ),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      title: SvgPicture.asset(
        "assets/icons/logo.svg",
        height: 26,
      ),
      actions: [
        IconButton(
          icon: SvgPicture.asset(
            "assets/icons/cart.svg",
            color: Theme.of(context).accentColor,
            width: 20,
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}
