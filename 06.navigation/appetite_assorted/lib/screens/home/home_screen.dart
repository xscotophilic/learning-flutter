import 'package:appetite_assorted/models/meal.dart';
import 'package:appetite_assorted/screens/categories/categories_grid_view.dart';
import 'package:appetite_assorted/screens/favorites/favorites_list_view.dart';
import 'package:appetite_assorted/screens/widgets/common/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class _PageData {
  const _PageData({
    required this.title,
    required this.icon,
    required this.page,
  });

  final String title;
  final IconData icon;
  final Widget page;
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.favouriteMeals});

  final List<Meal> favouriteMeals;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedPageIndex = 0;
  late final List<_PageData> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const _PageData(
        title: 'Categories',
        icon: Icons.category,
        page: CategoriesGridView(),
      ),
      _PageData(
        title: 'Favorites',
        icon: Icons.favorite,
        page: FavoritesListView(favouriteMeals: widget.favouriteMeals),
      ),
    ];
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  AppBar _buildAppBar(BuildContext context) {
    final iconColor = Theme.of(context).appBarTheme.iconTheme?.color;

    final ColorFilter? colorFilter;
    if (iconColor != null) {
      colorFilter = ColorFilter.mode(iconColor, BlendMode.srcIn);
    } else {
      colorFilter = null;
    }

    return AppBar(
      elevation: 0,
      leading: Builder(
        builder: (context) {
          return IconButton(
            icon: SvgPicture.asset(
              'assets/icons/menu.svg',
              colorFilter: colorFilter,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          );
        },
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
    final page = _pages[index];
    final icon = page.icon;
    final label = page.title;

    final Color color;
    if (_selectedPageIndex == index) {
      color = Theme.of(context).colorScheme.secondary;
    } else {
      color = Theme.of(context).colorScheme.onPrimary;
    }

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
    return Scaffold(
      appBar: _buildAppBar(context),
      drawer: const MainDrawer(),
      bottomNavigationBar: _buildbottomNavigationBar(context),
      body: _pages[_selectedPageIndex].page,
    );
  }
}
