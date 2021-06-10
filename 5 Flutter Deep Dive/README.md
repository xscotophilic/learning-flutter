<p align="center">
  <img src="https://user-images.githubusercontent.com/47301282/121462257-f755b500-c9cd-11eb-9f15-4eecef3dbd5e.png" alt="Flutter Deep Dive"/>
</p>

### Widget, Element and Render Object

- Widget: Anyone who has worked with Flutter is familiar with the term "Widget." A Widget is immutable, any changes to the user interface need the creation of a new Widget. How come it is so fast if a new Widget is required every time we alter something in the UI? Flutter makes use of three instances of trees under the hood. `Widget tree, Element tree, and Render Object tree`; when combined, they provide quick UI rendering and high performance.

- Element: In contrast to Widget, Element is modifiable. It means that properties within an element can be updated without the need for a new one to be created. Element is in charge of updating the UI, acting as a bridge between Widget and Render Object.

- Render Object: is the source of information for drawing the UI. Flutter tries to create a new Render Object only when necessary.

### Combining all trees

```
  String _text = "Hello";

  ElevatedButton(
    onPressed: () {_text = "World"},
    child: Text(_text),
  ),
```

1. Flutter will create a Widget tree from all the Widgets used above.

2. For each Widget in the tree, Flutter will create an Element by calling the createElement() method on the widget. That is how the Element tree is created.

3. For each Element in the tree, Flutter will create a Render Object by calling createRenderObject() on a widget, creating a Render Object tree.

<p align="center">
  <img src="https://user-images.githubusercontent.com/47301282/121461838-40f1d000-c9cd-11eb-8dd6-36a83ec4c209.png" alt="trees"/>
  
  Image scource iteo.com
</p>

### Example of how trees are managed

- Suppose we create a Button Widget (Refere above code). When we press this button, the text inside it will change from "Hello" to "World”.

  - The runtime types of the Text Widget (child of ElevatedButton) and its Render Object will be compared by an element object that contains references to both. If they differ, a new Render Object with new values is created.

  - If the runtime type remains the same, there is no need to construct a new Render Object; only properties will change, and updateRenderObject() will be called, saving a significant amount of time.

  - In our situation, the second scenario will occur. Both the Element and the Render Object will remain same; the only thing that will change is a Text Widget attribute and the creation of a new Widget. This doesn't affect us because Widget objects are lightweight and extremely fast to produce.

  - Optimizations like the ones mentioned above allow Flutter to render the user interface very quickly. However, each build necessitates a comparison of each Element in the tree's Widget and Render Object, which can take a long time for some extremely complicated views with dozens of Widgets.

- the widget tree is constantly changing basically whenever you call set state for example, so whenever the build methods get executed, Flutter rebuilds that widget tree, whilst that happens relatively often, the element tree is managed differently and does not rebuild with every call to the build method.

## How Flutter Rebuilds & Repaints the Screen

what happens if the widgets are replaced with new instances?

Does this mean that the othe same elements and the rendered objects, also rebuild?

we call set state, so something changes there, hence the build method gets called, now we have to realize that the state is managed in a separate object So the state is connected to the element and not directly connect to the widget. So when you call set state, that edits this state object. Set state is called, So that new state we have stored in that state object here is passed down to the children. and the build method is called.
So let's say we get a new instance for the state, we get a new instance for every object which is dirty/ changed. But what does this now mean for the element and the render tree, since we have new widget instances. No, it does not mean that. The elements hold a reference at a widget. So it knows which child elements it has.

<p align="center">
  <img src="https://user-images.githubusercontent.com/47301282/121457453-52cf7500-c9c5-11eb-83bc-f07d738e9774.png" alt="diag"/>
</p>

<p align="center">
<a href="https://user-images.githubusercontent.com/47301282/121457471-595dec80-c9c5-11eb-9fda-9afcf2088f1e.png">
High resolution drawing
</a>
</p>

<p align="center">
  <img src="https://user-images.githubusercontent.com/47301282/121457489-5ebb3700-c9c5-11eb-8e5c-857898cdba62.png" alt="steps"/>
</p>

So since that is known, when we get a new stateful widget up there which replaces the existing one, what Flutter does is it checks in that position of the widget tree or of the element tree, which is kind of the same here, because I'm getting a new my stateful widget and if the answer is yes, it simply updates its reference to new point it then passes this information on to the render object which is also kept, so that the render object can update in the places where it needs to update.

So for example if the background color is the same but the text changed (As we change text using Set State), the render object will only re-render the text pixels.

It has this element tree which is not rebuilt whenever build is called, only the widget tree is rebuilt. this is how repainting is done.
