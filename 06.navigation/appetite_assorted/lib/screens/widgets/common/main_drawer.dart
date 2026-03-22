import 'package:appetite_assorted/screens/filters/filters_screen.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  Widget _buildListTile({
    required ThemeData theme,
    required IconData icon,
    required String title,
    required double fontSize,
    required Function tapHandler,
  }) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      leading: Icon(icon, size: 24, color: theme.colorScheme.onSurface),
      title: Text(title, style: TextStyle(fontSize: fontSize)),
      onTap: () => tapHandler(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final double longestSide = mediaQuery.size.longestSide;

    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Appetite Assorted',
                style: TextStyle(fontSize: longestSide * 0.024),
              ),
              const SizedBox(height: 16),
              _buildListTile(
                theme: theme,
                icon: Icons.rule,
                title: 'Filters',
                fontSize: longestSide * 0.02,
                tapHandler: () => Navigator.of(
                  context,
                ).pushReplacementNamed(FiltersScreen.routeName),
              ),
              _buildListTile(
                theme: theme,
                icon: Icons.settings,
                title: 'Settings',
                fontSize: longestSide * 0.02,
                tapHandler: () =>
                    Navigator.of(context).pushReplacementNamed('/settings'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
