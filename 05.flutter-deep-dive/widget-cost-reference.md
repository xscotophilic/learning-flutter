# Widget Cost Reference

> Sorted from cheapest to most expensive in terms of layout and rendering cost.

## Essentially Free

- `SizedBox`: fixed size or gap, simplest render object possible
- `Spacer`: empty flexible space in a Row/Column
- `Padding`: adjusts layout constraints, no painting involved
- `Divider` / `VerticalDivider`: single line, minimal paint
- `Icon`: single glyph from a font, no layout complexity

## Very Cheap

- `Align`: repositions child, minimal layout work
- `Center`: Align with a fixed value, just as cheap
- `Expanded` / `Flexible`: adjusts flex constraints, no painting
- `FractionallySizedBox`: fraction-based constraints, no painting
- `ConstrainedBox`: adds min/max constraints, no painting
- `AspectRatio`: one constraint calculation, no painting
- `Visibility`: shows/hides, but hidden widgets still take space
- `Opacity`: cheap if static, expensive if animated (triggers compositing)

## Cheap

- `Text`: single style, single layout pass
- `StatelessWidget`: just calls build(), no state overhead
- `Row` / `Column`: linear layout pass across children
- `Wrap`: like Row/Column with an extra line-break pass
- `DecoratedBox`: paints background/border, no layout impact
- `ClipRRect` / `ClipOval`: clips during paint, not layout
- `Card`: thin wrapper over DecoratedBox + Material

## Moderate

- `StatefulWidget`: adds State object, lifecycle overhead
- `Container`: composes multiple widgets depending on properties set
- `Stack`: positions each child independently, more layout work
- `GestureDetector`: adds hit-testing on every frame
- `InkWell`: GestureDetector + ripple animation layer
- `SelectableText`: full text selection engine underneath
- `TextField` / `TextFormField`: input engine, focus management, cursor painting
- `Image` (asset): decoded once, cheap after first render
- `CircleAvatar`: clip + paint, moderate cost
- `Form`: manages field validation state across children
- `Checkbox` / `Switch` / `Radio` / `Slider`: stateful + animated

## Expensive

- `ListView` / `GridView`: viewport calculations, but lazy-loads children
- `CustomScrollView`: slivers each do their own layout protocol
- `SingleChildScrollView`: renders entire child at once, no lazy loading ⚠️
- `PageView`: renders adjacent pages, heavier than ListView
- `RichText`: multiple text spans, complex layout pass
- `AnimatedBuilder`: rebuilds render object on every animation tick
- `FutureBuilder` / `StreamBuilder`: async state + rebuild on every emission
- `Image` (network): decode + cache overhead on first load
- `FadeInImage`: animation layer on top of network image cost
- `Dialog` / `BottomSheet`: new overlay route, separate render tree

## Most Expensive

- `Scaffold`: composes many heavy widgets (AppBar, Drawer, FAB, SnackBar layer)
- `LayoutBuilder`: triggers parent layout pass to read constraints
- `ValueListenableBuilder`: fine if scoped small, expensive if wrapping large subtrees
- `RefreshIndicator`: physics simulation on top of scroll
- `Opacity` (animated): forces its own compositing layer, expensive at scale
- `DropdownButton`: creates a new overlay route on tap
- `ScrollBar`: scroll position listener on every frame

> [!TIP]
> The biggest wins come from the bottom of this list: replacing `SingleChildScrollView` with `ListView`, scoping `ValueListenableBuilder` to the smallest possible subtree, and avoiding animated `Opacity` in favour of `AnimatedOpacity` which is GPU-accelerated.
