import 'package:flutter/material.dart';
import 'package:my_store/core/consts/app_dimensions.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({
    super.key,
    required this.title,
    required this.leadingIcon,
    required this.onLeadingTap,
    this.trailing,
  });

  final String title;
  final IconData leadingIcon;
  final VoidCallback onLeadingTap;
  final Widget? trailing;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final actions = <Widget>[];
    if (trailing != null) {
      actions.add(
        Padding(
          padding: const EdgeInsets.only(right: AppDimensions.defaultPadding),
          child: trailing,
        ),
      );
    }

    return AppBar(
      title: Text(
        title,
        style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
      ),
      centerTitle: true,
      leading: GestureDetector(onTap: onLeadingTap, child: Icon(leadingIcon)),
      actions: actions,
    );
  }
}
