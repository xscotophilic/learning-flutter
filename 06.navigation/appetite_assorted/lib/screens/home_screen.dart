import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:appetite_assorted/models/meal.dart';
import 'package:appetite_assorted/widgets/main_drawer.dart';
import 'package:appetite_assorted/screens/all_categories_screen.dart';
import 'package:appetite_assorted/screens/favorites_screen.dart';

class HomeScreen extends StatefulWidget {
  final List<Meal> favouriteMeals;
  const HomeScreen({Key? key, required this.favouriteMeals}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;

  @override
  void initState() {
    _pages = [
      {
        'page': CategoriesScreen(),
        'title': 'Categories',
      },
      {
        'page': FavoritesScreen(favouriteMeals: widget.favouriteMeals),
        'title': 'Favorites',
      },
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: buildAppBar(context),
          drawer: MainDrawer(),
          bottomNavigationBar: buildbottomNavigationBar(context),
          body: _pages[_selectedPageIndex]['page'] as Widget,
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: Builder(
        builder: (context) => IconButton(
          icon: SvgPicture.asset(
            "assets/icons/menu.svg",
            color: Theme.of(context).accentColor,
          ),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      title: Text('Appetite Assorted'),
    );
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
    _pages[index];
  }

  BottomNavigationBar buildbottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Theme.of(context).primaryColor,
      unselectedItemColor: Colors.white70,
      selectedItemColor: Theme.of(context).accentColor,
      currentIndex: _selectedPageIndex,
      onTap: _selectPage,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.category),
          label: 'Categories',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Favorites',
        ),
      ],
    );
  }
}
