import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:appetite_assorted/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';

  final Map<String, bool> currentFilters;
  final Function setFiltersHandler;
  const FiltersScreen({
    Key? key,
    required this.setFiltersHandler,
    required this.currentFilters,
  }) : super(key: key);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _isGlutenFree = false;
  bool _isVegan = false;
  bool _isVegetarian = false;
  bool _isLactoseFree = false;

  @override
  void initState() {
    _isGlutenFree = widget.currentFilters['isGlutenFree'] as bool;
    _isLactoseFree = widget.currentFilters['isLactoseFree'] as bool;
    _isVegan = widget.currentFilters['isVegan'] as bool;
    _isVegetarian = widget.currentFilters['isVegetarian'] as bool;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: MainDrawer(),
        appBar: buildAppBar(context, 'Filters'),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                'Adjust your meal selection!',
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  _buildSwitchListTile(
                    'Gluten Free',
                    _isGlutenFree,
                    (newValue) {
                      setState(() {
                        _isGlutenFree = newValue;
                      });
                    },
                  ),
                  _buildSwitchListTile(
                    'Vegan',
                    _isVegan,
                    (newValue) {
                      setState(() {
                        _isVegan = newValue;
                      });
                    },
                  ),
                  _buildSwitchListTile(
                    'Vegetarian',
                    _isVegetarian,
                    (newValue) {
                      setState(() {
                        _isVegetarian = newValue;
                      });
                    },
                  ),
                  _buildSwitchListTile(
                    'Lactose Free',
                    _isLactoseFree,
                    (newValue) {
                      setState(() {
                        _isLactoseFree = newValue;
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
    updateValue,
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
            "assets/icons/menu.svg",
            color: Theme.of(context).accentColor,
          ),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      title: Text(title),
      actions: [
        IconButton(
          onPressed: () => widget.setFiltersHandler({
            'isGlutenFree': _isGlutenFree,
            'isVegan': _isVegan,
            'isVegetarian': _isVegetarian,
            'isLactoseFree': _isLactoseFree,
          }),
          icon: Icon(
            Icons.save,
          ),
        )
      ],
    );
  }
}
