import 'package:appetite_assorted/screens/filters_screen.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        elevation: 0,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text(
                    'Appetite Assorted',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            buildListTile(
              context: context,
              title: 'Meals',
              icon: Icons.restaurant,
              tapHandler: () => Navigator.of(context).pushReplacementNamed('/'),
            ),
            buildListTile(
              context: context,
              title: 'Filters',
              icon: Icons.filter,
              tapHandler: () => Navigator.of(context)
                  .pushReplacementNamed(FiltersScreen.routeName),
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
    required BuildContext context,
    required String title,
    required IconData icon,
    required Function tapHandler,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        size: 24,
        color: Theme.of(context).accentColor,
      ),
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .headline6!
            .copyWith(color: Theme.of(context).accentColor),
      ),
      onTap: () => tapHandler(),
    );
  }
}
