# Flutter Deep Dive

To build high-performance Flutter apps, we need to look under the hood and understand how the framework actually renders pixels on the screen.

## The Three Trees

Flutter's UI system uses three parallel trees working together to efficiently render your app.

| Tree                   | Object Type    | Stability     | Purpose                                                                              |
| :--------------------- | :------------- | :------------ | :----------------------------------------------------------------------------------- |
| **Widget Tree**        | `Widget`       | **Immutable** | A "blueprint" or configuration for what the UI should look like. Rebuilt frequently. |
| **Element Tree**       | `Element`      | **Mutable**   | The "glue" that manages the lifecycle and links widgets to the render objects.       |
| **Render Object Tree** | `RenderObject` | **Stable**    | The "source of truth" for layout and painting. Only updated/rebuilt when necessary.  |

> [!IMPORTANT]
> Because Widgets are lightweight and immutable, Flutter can rebuild the Entire Widget Tree frequently without a significant performance hit. The complexity is handled by the Element and Render Object trees.

### Why do we need all three trees?

Imagine you're building a UI framework from scratch. You'd quickly run into two problems that directly fight each other:

**Problem 1** - You need to describe UI changes constantly, 60 times per second. So descriptions need to be dirt cheap and throwaway.

**Problem 2** - Actually drawing things on screen is expensive. Calculating sizes, positions, and painting pixels can't be thrown away and redone from scratch 60 times per second.

You can't solve both problems with one object. So Flutter splits the job:

- Widgets handle the cheap descriptions - throwaway, rebuilt constantly
- Render Objects handle the expensive drawing - stable, reused as much as possible

But now you have a new problem - **widgets get thrown away every frame, so how does a render object know which widget belongs to it across rebuilds?** Something needs to sit in the middle, survive across rebuilds, and say _"this new widget belongs to that existing render object - just update it, don't rebuild."_

That's your three trees.

<p>
  <img src="assets/three-trees.svg" alt="Three Trees" />
</p>

### If you tried to remove one...

**Remove Widget Tree** - you'd write UI by directly mutating render objects. This is how old Android/iOS worked. It got messy and error-prone fast.

**Remove Element Tree** - widgets and render objects have no way to find each other across rebuilds. Every update destroys and recreates everything. Kills performance.

**Remove Render Object Tree** - widgets would have to do layout themselves. They'd need to become stateful and long-lived. At that point they're just render objects with a different name.

Each tree exists because the other two **cannot do its job.** Now let's deep dive into each tree.

### 1. Widget Tree

A Widget is just a **description** of what the UI should look like - not the actual UI itself. Think of it like an **order form at a restaurant**. It says "I want a burger with cheese" - but it's not the burger itself.

```dart
Text('Hello', style: TextStyle(fontSize: 16))
```

This widget isn't drawing anything on screen. It's just saying **"show some text that looks like this."**

Every widget is **frozen the moment it's created** - you can never change it. So when your state changes, Flutter simply **throws the old widget away and creates a brand new one.** This sounds wasteful, but widgets are so lightweight that it happens 60+ times per second without breaking a sweat.

> [!IMPORTANT]
> A widget is like a sticky note with instructions on it. When the instructions change, you don't erase the note - you throw it away and write a fresh one.

One important thing to note - for **StatefulWidgets**, Flutter separates two things:

- The **widget** - the frozen config, gets thrown away on every rebuild
- The **State object** - survives rebuilds and is where your actual data lives (like `count`, `isLoading`, etc.)

This is why your data doesn't disappear every time the screen updates.

### 2. Element Tree

If widgets are sticky notes, Elements are the **notice board** those sticky notes get pinned to.

The notice board itself **never goes away.** When state changes, you just swap the sticky note - but the board stays exactly where it is.

When `setState()` fires, each Element looks at the new widget and asks two questions:

- **Same type of widget as before?** -> just update what changed, keep everything underneath (cheap)
- **Completely different type of widget?** -> tear everything down and start fresh (expensive)

```
// Flutter sees this change:
Before:  Text('Hello')
After:   Text('Hi')

Same type (Text) -> Element just updates the text. Nothing else rebuilt.

// But this:
Before:  Text('Hello')
After:   Icon(Icons.star)

Different type -> Element tears down and rebuilds from scratch.
```

This is why Flutter is fast - it does the **minimum amount of work possible** on every update.

### 3. Render Object Tree

Render objects are the **construction workers** - they do the actual heavy lifting of measuring, positioning, and drawing everything on screen.

They are expensive to create, so Flutter tries its best to **never throw them away.** The Element tree exists largely just to protect render objects from being unnecessarily recreated.

- Render objects calculate sizes and positions (layout)
- Then they draw everything to the screen (paint)
- This is what actually talks to the GPU

### The Key Insight

Flutter's speed comes from one simple idea - **only do expensive work when absolutely necessary.**

### How Trees are Created

When Flutter sees a widget in your code for the first time, it does two things:

**Step 1 - Create an Element**
Flutter calls `createElement()` on the widget. This creates the long-lived manager object that will survive future rebuilds.

**Step 2 - Create a Render Object**
The Element calls `createRenderObject()` to create the actual object that does layout and painting.

This only happens **once** per widget position in the tree. After that, Flutter reuses the Element and Render Object - it never repeats this process unless the widget type changes entirely.

### How Rebuilding Works

When you call `setState()`, Flutter doesn't rebuild everything from scratch. It's much smarter than that.

**Step 1 - Mark as dirty**
The Element is flagged as dirty. Flutter doesn't do anything yet - it waits until the next frame.

**Step 2 - Rebuild the widget**
Flutter calls `build()`, which creates a fresh widget instance with the new configuration.

**Step 3 - Compare old vs new**
The Element looks at the new widget and asks: is this the same type as before?

```
// Same type - cheap path
Before:  Text('Hello')
After:   Text('Hi')
-> Element keeps everything, just patches the render object with new text

// Different type - expensive path
Before:  Text('Hello')
After:   Icon(Icons.star)
-> Element tears down the render object and builds a new one from scratch
```

**Step 4 - Update only what changed**
If the type matches, Flutter calls `updateRenderObject()` - which only updates the specific properties that actually changed. Not a full repaint, just a surgical patch.

The key thing to understand is that **State lives on the Element, not on the Widget.** When you call `setState()`, you're updating the State object that the Element holds onto. Since the Element survives rebuilds, your data survives too - even though the widget itself gets thrown away and recreated.

```
Widget    ->  thrown away and recreated every rebuild
Element   ->  survives, holds your State object
State     ->  survives, holds your actual data (count, isLoading, etc.)
```

This is why `count` doesn't reset to zero every time your screen updates.

### Performance

When you mark a widget as `const`, you're telling Flutter two things:

1. This widget will **never change**
2. It can be **shared** - there's no need to create a new instance every rebuild

```dart
// Without const - new instance created on every rebuild
child: Text('Hello')

// With const - same instance reused forever, rebuild skipped entirely
child: const Text('Hello')
```

Flutter sees a `const` widget and skips the comparison step entirely. It already knows nothing changed - there's nothing to diff.

> [!TIP]
> `const` is one of the easiest performance wins in Flutter. Use it on any widget whose content never changes - static labels, icons, padding, decorations. In large apps or complex animations, this adds up significantly.

### Lifecycles

#### 1. StatefulWidget Lifecycle

A `StatefulWidget` goes through a predictable series of stages from the moment it appears on screen to the moment it's removed.

**`createState()`**
Called immediately when the widget is inserted into the tree. Creates the State object that will live alongside the Element.

**`initState()`**
Called once, right after the State is created. This is where you do one-time setup - initializing controllers, subscribing to streams, making your first API call.

```dart
@override
void initState() {
  super.initState();
  _controller = AnimationController(vsync: this);
}
```

**`didChangeDependencies()`**
Called after `initState()` and whenever something your widget depends on changes - like the app's Theme or Locale.

**`build()`**
Called every time the UI needs to render. This is the method that returns your widget tree. Keep it fast and free of side effects - it can be called many times.

**`didUpdateWidget()`**
Called when the parent widget rebuilds and passes new data down. Useful for reacting to prop changes.

**`dispose()`**
Called when the widget is permanently removed from the tree. This is where you clean up - cancel subscriptions, dispose controllers, clear listeners. Forgetting this is one of the most common causes of memory leaks in Flutter.

```dart
@override
void dispose() {
  _controller.dispose(); // always clean up
  super.dispose();
}
```

The full journey looks like this:

```
Insert into tree
      │
  createState()
      │
  initState()          <- one-time setup
      │
  didChangeDependencies()
      │
  build()              <- renders UI
      │
      ├── setState() called -> build() again
      │
      ├── parent rebuilds -> didUpdateWidget() -> build() again
      │
  dispose()            <- removed from tree, clean up here
```

#### 2. App Lifecycle

Flutter also exposes the app's own lifecycle - how it responds when the user backgrounds it, gets a phone call, or closes it entirely.

**`resumed`** - App is visible and in the foreground. The user is actively using it.

**`inactive`** - App is partially obscured - incoming call, switching apps, etc. The app is still running but not receiving user input.

**`paused`** - App is in the background. It's still alive in memory but not visible. Good place to pause expensive operations.

**`detached`** - The Flutter engine is running but not attached to any view. This happens just before the app is fully terminated.

```
User opens app      ->  resumed
Incoming call       ->  inactive
User backgrounds    ->  paused
User closes app     ->  paused -> detached
User returns        ->  resumed
```

To listen to these changes, mix in `WidgetsBindingObserver` and override `didChangeAppLifecycleState()`.

---

### Core Concepts

#### BuildContext

`BuildContext` sounds abstract but it's actually simple - **it's just the Element for that widget.**

Every `build()` method receives a `context` parameter. That context is the widget's Element, and it represents the widget's **position in the tree**. This is why you can use it to look up things above you:

```dart
// These all climb UP the tree to find what they need
Theme.of(context)        // finds the nearest Theme
Navigator.of(context)    // finds the nearest Navigator
MediaQuery.of(context)   // finds the nearest MediaQuery
```

A common mistake beginners make is using a `context` that belongs to a widget that's too high in the tree - before the thing you're looking for has been inserted. If you ever see a "could not find ancestor" error, this is usually why.

#### Keys

By default, when Flutter compares old and new widgets, it only checks the **type**. Two `Text` widgets are considered the same position in the tree - even if they represent completely different items.

This becomes a problem when you have a **list of stateful widgets** and you reorder them:

```dart
// Flutter sees: Text, Text, Text
// It has no idea which Text moved where
// State gets attached to the wrong widget
Column(children: [TextBox(), TextBox(), TextBox()])
```

Keys solve this by giving each widget a **stable identity** that survives reordering.

```dart
Column(children: [
  TextBox(key: ValueKey('a')),
  TextBox(key: ValueKey('b')),
  TextBox(key: ValueKey('c')),
])
```

Now Flutter knows exactly which widget is which - even after reordering.

**`LocalKey`** - identifies a widget among its siblings. Use `ValueKey` (based on a value like an ID) or `ObjectKey` (based on an object reference).

**`GlobalKey`** - identifies a widget across the entire tree. Lets you access a widget's State from anywhere, or move a widget to a completely different part of the tree without losing its State. Use sparingly - overusing GlobalKeys is a common source of bugs.

> [!TIP]
> A good rule of thumb - if you have a list of stateful widgets that can be reordered, filtered, or removed, always give them keys.

## Further Reading

- [Inside Flutter](https://flutter.dev/docs/resources/inside-flutter)
