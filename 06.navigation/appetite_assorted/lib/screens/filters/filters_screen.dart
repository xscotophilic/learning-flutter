import 'package:appetite_assorted/models/meal.dart';
import 'package:flutter/material.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({
    super.key,
    required this.currentFilters,
    required this.setFiltersHandler,
  });

  static const routeName = '/filters';

  final Map<DietaryType, bool> currentFilters;
  final void Function(Map<DietaryType, bool>) setFiltersHandler;

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

  String _getDietaryTypeLabel(DietaryType type) {
    switch (type) {
      case DietaryType.glutenFree:
        return 'Gluten Free';
      case DietaryType.lactoseFree:
        return 'Lactose Free';
      case DietaryType.vegan:
        return 'Vegan';
      case DietaryType.vegetarian:
        return 'Vegetarian';
    }
  }

  AppBar _buildAppBar(BuildContext context, String title) {
    return AppBar(title: Text(title));
  }

  Widget _buildBottomNavigationBar() {
    return ColoredBox(
      color: Theme.of(context).colorScheme.primary,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Back'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    foregroundColor: Theme.of(context).colorScheme.onSurface,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () =>
                      Navigator.of(context).pushReplacementNamed('/'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.save),
                  label: const Text('Save'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.onPrimary,
                    foregroundColor: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    widget.setFiltersHandler(_filters);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Filters saved!',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSwitchListTile({
    required String title,
    required bool currentValue,
    required ValueChanged<bool> onToggle,
    required double fontSize,
  }) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: SwitchListTile.adaptive(
        inactiveThumbColor: Theme.of(context).colorScheme.primary,
        inactiveTrackColor: Theme.of(context).colorScheme.onPrimary,
        activeTrackColor: Theme.of(context).colorScheme.secondary,
        title: Text(title, style: TextStyle(fontSize: fontSize)),
        contentPadding: const EdgeInsets.all(0),
        value: currentValue,
        onChanged: onToggle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double fontSize = MediaQuery.of(context).size.longestSide * 0.020;
    return Scaffold(
      appBar: _buildAppBar(context, 'Filters'),
      bottomNavigationBar: _buildBottomNavigationBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Text(
                'Adjust your meal selection!',
                style: TextStyle(fontSize: fontSize),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView(
                  children: DietaryType.values.map((type) {
                    return _buildSwitchListTile(
                      title: _getDietaryTypeLabel(type),
                      currentValue: _isActive(type),
                      onToggle: (bool value) {
                        setState(() {
                          _filters[type] = value;
                        });
                      },
                      fontSize: fontSize,
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
