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

For every Widget in your code, Flutter performs the following steps:

1.  **`createElement()`**: Called on the widget to create its corresponding Element.
2.  **`createRenderObject()`**: Called by the Element (if it's a renderable widget) to create the Render Object.

<p align="center">
  <img src="https://user-images.githubusercontent.com/47301282/121461838-40f1d000-c9cd-11eb-8dd6-36a83ec4c209.png" alt="trees" width="600px"/>
</p>

## How Rebuilding Works

<p align="center">
  <img src="https://user-images.githubusercontent.com/47301282/121463717-2a994380-c9d0-11eb-8493-92f5b876be08.png" alt="how trees are managed"/>
</p>

When you call `setState()`, Flutter marks an Element as **dirty**. During the next frame:

1.  **Rebuild Widget**: The `build()` method is called, creating a new Widget instance.
2.  **Comparison**: The Element compares the _runtime type_ and _key_ of the new widget with the old one.
3.  **Shortcutting (`updateRenderObject`)**: If they match, the Element updates its reference to the new widget. It calls `updateRenderObject()` to only update the specific properties that changed (e.g., text color), saving significant time.
4.  **Full Rebuild**: If the type or key changes, a new Render Object is created.

### The Element-State Relationship

One of the most critical concepts in Flutter is that **the `State` is connected to the `Element`, not directly to the `Widget`.**

<p align="center">
  <img src="https://user-images.githubusercontent.com/47301282/121463715-2a00ad00-c9d0-11eb-9ea4-e530c9e7bcc8.png" alt="How Flutter Rebuilds & Repaints the Screen"/>
</p>

When you call `setState()`, you are editing the **State object** held by the Element. Since the Element persists while the Widgets are replaced, the State survives rebuilds.

<p align="center">
  <img src="https://user-images.githubusercontent.com/47301282/121457453-52cf7500-c9c5-11eb-83bc-f07d738e9774.png" alt="diag"/>
  <br/>
  <a href="https://user-images.githubusercontent.com/47301282/121457471-595dec80-c9c5-11eb-9fda-9afcf2088f1e.png">View High Resolution Drawing</a>
</p>

<p align="center">
  <img src="https://user-images.githubusercontent.com/47301282/121457489-5ebb3700-c9c5-11eb-8e5c-857898cdba62.png" alt="steps"/>
</p>

## Performance & `const`

<p align="center">
  <img src="https://user-images.githubusercontent.com/47301282/121525107-9b168380-ca15-11eb-877d-f51b5c11f15d.png" alt="Using const"/>
</p>

Using the `const` keyword on widgets indicates that the object will never change.

```dart
child: const Text('Learning flutter.'); // Skip rebuild comparison
```

> [!TIP]
> `const` decreased the work required of the Garbage Collector. It's a minor performance boost that builds up in large apps or apps with complex animations.

## Lifecycles

Understanding when code executes is vital for managing resources.

### 1. Widget Lifecycle (Stateful)

The journey of a `StatefulWidget` from insertion to removal:

<p align="center">
  <img src="https://user-images.githubusercontent.com/47301282/121525108-9baf1a00-ca15-11eb-9d48-a93d9bc7fdfd.png" alt="Widget life cycle"/>
</p>

1.  **`createState()`**: Immediately called to create the state object.
2.  **`initState()`**: First method called after creation. Perfect for one-time setup.
3.  **`didChangeDependencies()`**: Called when dependencies (like Theme or Locale) change.
4.  **`build()`**: Called every time the UI needs to be rendered.
5.  **`didUpdateWidget()`**: Called if the parent widget is rebuilt and sends new data.
6.  **`dispose()`**: Called when the widget is removed permanently. Used to clear controllers/listeners.

> [!NOTE]
> Read more: [Life cycle in flutter - StackOverflow](https://stackoverflow.com/questions/41479255/life-cycle-in-flutter)

### 2. App Lifecycle

How the app responds to system-level events (backgrounded, resumed, etc.):

<p align="center">
  <img src="https://user-images.githubusercontent.com/47301282/121525097-98b42980-ca15-11eb-8844-7dc77ad26c14.png" alt="App life cycle"/>
</p>

- **`Resumed`**: App is visible and responding to user input.
- **`Inactive`**: App is in a transition state (e.g., incoming call).
- **`Paused`**: App is in the background.
- **`Detached`**: The engine is detached from any views.

> [!NOTE]
> Read more: [Flutter App Life cycle - Medium](https://medium.com/pharos-production/flutter-app-lifecycle-4b0ab4a4211a)

## Core Concepts

### BuildContext

<p align="center">
  <img src="https://user-images.githubusercontent.com/47301282/121525101-99e55680-ca15-11eb-9c39-c7161f5eda13.png" alt="BuildContext"/>
</p>

**`BuildContext` is technically the `Element`** presiding over a widget. It represents a widget's location in the tree and is used to:

- **Interact with parents**: Look up data like `Theme.of(context)` or `Navigator.of(context)`.
- **Get positioning**: Once rendered, get the screen size and position of the widget.

### Keys

<p align="center">
  <img src="https://user-images.githubusercontent.com/47301282/121525104-9a7ded00-ca15-11eb-9d3d-b15361f58b1b.png" alt="Keys"/>
</p>

Keys help Flutter identify which widgets have changed. They are essential when reordering collections of stateful widgets.

- **`LocalKey`**: Differentiate widgets among siblings (e.g., `ValueKey`).
- **`GlobalKey`**: Access a child's state from a parent or move a widget across the entire app tree without losing state.

> [!TIP]
> Watch: [When to use Keys - Flutter (Google)](https://youtu.be/kn0EOS-ZiIc)

---

## Further Reading

- [Inside Flutter](https://flutter.dev/docs/resources/inside-flutter)
- [Keys! What are they good for?](https://medium.com/flutter/keys-what-are-they-good-for-13cb51742e7d)
