import 'package:flutter/material.dart';
import 'package:my_store/core/consts/app_consts.dart';
import 'package:my_store/shared/widgets/decorated_icon_cta.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({
    super.key,
    required this.title,
    required this.leadingIcon,
    required this.onLeadingTap,
    this.trailingIcon,
    this.onTrailingTap,
  });

  final String title;
  final IconData leadingIcon;
  final VoidCallback onLeadingTap;
  final IconData? trailingIcon;
  final VoidCallback? onTrailingTap;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final actions = <Widget>[];
    if (trailingIcon != null) {
      actions.add(
        Padding(
          padding: const EdgeInsets.only(right: AppConsts.defaultPadding),
          child: DecoratedIconCta(icon: trailingIcon!, onTap: onTrailingTap),
        ),
      );
    }

    return AppBar(
      title: Text(
        title,
        style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
      ),
      centerTitle: true,
      leading: DecoratedIconCta(icon: leadingIcon, onTap: onLeadingTap),
      actions: actions,
    );
  }
}
