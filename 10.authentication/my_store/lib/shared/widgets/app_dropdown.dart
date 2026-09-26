import 'package:flutter/material.dart';
import 'package:my_store/core/consts/app_dimensions.dart';

class AppDropdown extends StatefulWidget {
  const AppDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  final String value;
  final List<String> items;
  final ValueChanged<String> onChanged;

  @override
  State<AppDropdown> createState() => _AppDropdownState();
}

class _AppDropdownState extends State<AppDropdown> {
  bool _isOpen = false;

  void _toggle() => setState(() => _isOpen = !_isOpen);

  void _select(String item) {
    _toggle();
    widget.onChanged(item);
  }

  CrossFadeState get _crossFadeState {
    if (_isOpen) return CrossFadeState.showSecond;
    return CrossFadeState.showFirst;
  }

  List<String> get _filteredItems {
    return widget.items.where((item) => item != widget.value).toList();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final inputDecorationTheme = Theme.of(context).inputDecorationTheme;
    final radius = const Radius.circular(AppDimensions.defaultBorderRadius);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GestureDetector(
          onTap: _toggle,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: inputDecorationTheme.fillColor,
              borderRadius: BorderRadius.only(
                topLeft: radius,
                topRight: radius,
                bottomLeft: _isOpen ? Radius.zero : radius,
                bottomRight: _isOpen ? Radius.zero : radius,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.defaultPadding,
                vertical: AppDimensions.defaultPadding / 1.5,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(widget.value, style: textTheme.bodyMedium),
                  ),
                  AnimatedRotation(
                    turns: _isOpen ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: const Icon(Icons.keyboard_arrow_down_rounded),
                  ),
                ],
              ),
            ),
          ),
        ),

        AnimatedCrossFade(
          duration: const Duration(milliseconds: 200),
          crossFadeState: _crossFadeState,
          firstChild: const SizedBox.shrink(),
          secondChild: DecoratedBox(
            decoration: BoxDecoration(
              color: inputDecorationTheme.fillColor,
              borderRadius: BorderRadius.only(
                bottomLeft: radius,
                bottomRight: radius,
              ),
              border: Border(
                top: BorderSide(
                  color: Theme.of(context).colorScheme.primary.withAlpha(100),
                ),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: _filteredItems.map((item) {
                return GestureDetector(
                  onTap: () => _select(item),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.defaultPadding,
                      vertical: AppDimensions.defaultPadding / 1.5,
                    ),
                    child: Text(item),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
