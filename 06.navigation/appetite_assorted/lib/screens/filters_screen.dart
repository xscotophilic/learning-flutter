import 'package:appetite_assorted/models/meal.dart';
import 'package:appetite_assorted/widgets/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({
    super.key,
    required this.setFiltersHandler,
    required this.currentFilters,
  });

  static const routeName = '/filters';

  final Map<DietaryType, bool> currentFilters;
  final Function setFiltersHandler;

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  Map<DietaryType, bool> _filters = {};

  @override
  void initState() {
    super.initState();
    _filters = widget.currentFilters;
  }

  bool _isActive(DietaryType type) {
    return _filters[type] ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MainDrawer(),
      appBar: buildAppBar(context, 'Filters'),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Text(
                'Adjust your meal selection!',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  _buildSwitchListTile(
                    'Gluten Free',
                    _isActive(DietaryType.glutenFree),
                    (bool value) {
                      setState(() {
                        _filters[DietaryType.glutenFree] = value;
                      });
                    },
                  ),
                  _buildSwitchListTile('Vegan', _isActive(DietaryType.vegan), (
                    bool value,
                  ) {
                    setState(() {
                      _filters[DietaryType.vegan] = value;
                    });
                  }),
                  _buildSwitchListTile(
                    'Vegetarian',
                    _isActive(DietaryType.vegetarian),
                    (bool value) {
                      setState(() {
                        _filters[DietaryType.vegetarian] = value;
                      });
                    },
                  ),
                  _buildSwitchListTile(
                    'Lactose Free',
                    _isActive(DietaryType.lactoseFree),
                    (bool value) {
                      setState(() {
                        _filters[DietaryType.lactoseFree] = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchListTile(
    String title,
    bool currentValue,
    ValueChanged<bool> updateValue,
  ) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      onChanged: updateValue,
    );
  }

  AppBar buildAppBar(BuildContext context, String title) {
    return AppBar(
      elevation: 0,
      leading: Builder(
        builder: (context) => IconButton(
          icon: SvgPicture.asset(
            'assets/icons/menu.svg',
            colorFilter: ColorFilter.mode(
              Theme.of(context).colorScheme.onSurface,
              BlendMode.srcIn,
            ),
          ),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      title: Text(title),
      actions: [
        IconButton(
          onPressed: () => widget.setFiltersHandler(_filters),
          icon: const Icon(Icons.save),
        ),
      ],
    );
  }
}
