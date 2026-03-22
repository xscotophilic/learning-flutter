import 'package:appetite_assorted/screens/filters/filters_screen.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Drawer(
      elevation: 0,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Appetite Assorted',
                style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ),
            const SizedBox(height: 12),
            buildListTile(
              theme: theme,
              title: 'Meals',
              icon: Icons.restaurant,
              tapHandler: () => Navigator.of(context).pushReplacementNamed('/'),
            ),
            buildListTile(
              theme: theme,
              title: 'Filters',
              icon: Icons.filter,
              tapHandler: () => Navigator.of(
                context,
              ).pushReplacementNamed(FiltersScreen.routeName),
            ),
            // buildListTile(
            //   context: context,
            //   title: 'Settings',
            //   icon: Icons.settings,
            //   tapHandler: () => Navigator.of(context).pushNamed('/settings'),
            // ),
          ],
        ),
      ),
    );
  }

  ListTile buildListTile({
    required ThemeData theme,
    required String title,
    required IconData icon,
    required Function tapHandler,
  }) {
    return ListTile(
      leading: Icon(icon, size: 24, color: theme.colorScheme.onSurface),
      title: Text(
        title,
        style: theme.textTheme.titleMedium?.copyWith(
          color: theme.colorScheme.onSurface,
        ),
      ),
      onTap: () => tapHandler(),
    );
  }
}
