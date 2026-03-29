import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_svg/svg.dart';
import 'package:my_store/app_drawer.dart';
import 'package:my_store/providers/cart.dart';
import 'package:my_store/screens/cart/cart_screen.dart';
import 'package:my_store/screens/home/components/badge.dart';
import 'package:my_store/screens/home/components/body.dart';
import 'package:provider/provider.dart';

enum FilterOptions { favorites, all }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
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
                  'assets/icons/menu.svg',
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.secondary,
                    BlendMode.srcIn,
                  ),
                  width: 20,
                ),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
            title: SvgPicture.asset('assets/icons/logo.svg', height: 26),
            actions: [
              Consumer<Cart>(
                builder: (_, cart, Widget? child) => Badge(
                  value: cart.itemCount.toString(),
                  child: child ?? const SizedBox.shrink(),
                ),
                child: IconButton(
                  icon: SvgPicture.asset(
                    'assets/icons/cart.svg',
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.secondary,
                      BlendMode.srcIn,
                    ),
                    width: 17,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(CartScreen.routeName);
                  },
                ),
              ),
            ],
          ),
          drawer: const AppDrawer(),
          body: Center(child: HomeBody(showOnlyFavs: _showOnlyFavs)),
          floatingActionButton: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).colorScheme.secondary,
              ),
              shape: BoxShape.circle,
            ),
            child: PopupMenuButton(
              onSelected: (FilterOptions option) {
                setState(() {
                  if (option == FilterOptions.favorites) {
                    _showOnlyFavs = true;
                  } else {
                    _showOnlyFavs = false;
                  }
                });
              },
              itemBuilder: (_) => [
                PopupMenuItem(
                  value: FilterOptions.favorites,
                  child: Text(
                    'Favorites Only',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                PopupMenuItem(
                  value: FilterOptions.all,
                  child: Text(
                    'Show All',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
              child: Container(
                padding: const EdgeInsets.all(8),
                child: SvgPicture.asset(
                  'assets/icons/more.svg',
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.secondary,
                    BlendMode.srcIn,
                  ),
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
