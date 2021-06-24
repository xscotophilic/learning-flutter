import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:the_blue_store/app_drawer.dart';

import '../../providers/cart.dart';
import './components/body.dart';
import './components/badge.dart';
import '../../screens/cart/cart_screen.dart';

enum FilterOptions {
  Favorites,
  All,
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _showOnlyFavs = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
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
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
            title: SvgPicture.asset(
              "assets/icons/logo.svg",
              height: 26,
            ),
            actions: [
              Consumer<Cart>(
                builder: (_, cart, child) => Badge(
                  child: child as Widget,
                  value: cart.itemCount.toString(),
                ),
                child: IconButton(
                  icon: SvgPicture.asset(
                    "assets/icons/cart.svg",
                    color: Theme.of(context).accentColor,
                    width: 17,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(CartScreen.routeName);
                  },
                ),
              )
            ],
          ),
          drawer: AppDrawer(),
          body: Center(
            child: Body(showOnlyFavs: _showOnlyFavs),
          ),
          floatingActionButton: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).accentColor,
                width: 1,
              ),
              shape: BoxShape.circle,
            ),
            child: PopupMenuButton(
              onSelected: (FilterOptions option) {
                setState(() {
                  if (option == FilterOptions.Favorites) {
                    _showOnlyFavs = true;
                  } else {
                    _showOnlyFavs = false;
                  }
                });
              },
              itemBuilder: (_) => [
                PopupMenuItem(
                  child: Text(
                    'Favorites Only',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  value: FilterOptions.Favorites,
                ),
                PopupMenuItem(
                  child: Text(
                    'Show All',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  value: FilterOptions.All,
                ),
              ],
              child: Container(
                padding: EdgeInsets.all(8),
                child: SvgPicture.asset(
                  "assets/icons/more.svg",
                  color: Theme.of(context).accentColor,
                  width: 16,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
