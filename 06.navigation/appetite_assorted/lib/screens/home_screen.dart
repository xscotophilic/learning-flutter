import 'package:appetite_assorted/models/meal.dart';
import 'package:appetite_assorted/screens/all_categories_screen.dart';
import 'package:appetite_assorted/screens/favorites_screen.dart';
import 'package:appetite_assorted/widgets/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.favouriteMeals});

  final List<Meal> favouriteMeals;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pages = [
      {
        'title': 'Categories',
        'icon': Icons.category,
        'page': const CategoriesScreen(),
      },
      {
        'page': FavoritesScreen(favouriteMeals: widget.favouriteMeals),
        'icon': Icons.favorite,
        'title': 'Favorites',
      },
    ];
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: Builder(
        builder: (context) => IconButton(
          icon: SvgPicture.asset(
            'assets/icons/menu.svg',
            colorFilter: ColorFilter.mode(
              Theme.of(context).colorScheme.onPrimary,
              BlendMode.srcIn,
            ),
          ),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      title: const Text('Appetite Assorted'),
    );
  }

  Widget _buildbottomNavigationBar(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.primary,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 16,
            left: 16,
            right: 16,
            bottom: 8,
          ),
          child: Row(
            children: List.generate(_pages.length, (index) {
              return _buildNavBarItem(context, index);
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildNavBarItem(BuildContext context, int index) {
    final item = _pages[index];
    final icon = item['icon'] as IconData;
    final label = item['title'] as String;
    final isSelected = _selectedPageIndex == index;
    final color = isSelected
        ? Theme.of(context).colorScheme.secondary
        : Theme.of(context).colorScheme.onSecondary;

    return Expanded(
      child: InkWell(
        onTap: () => _selectPage(index),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color),
            Text(label, style: TextStyle(color: color)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: _buildAppBar(context),
        drawer: const MainDrawer(),
        bottomNavigationBar: _buildbottomNavigationBar(context),
        body: _pages[_selectedPageIndex]['page'] as Widget,
      ),
    );
  }
}
