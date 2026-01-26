# Concepts: Widgets, Styling, Adding Logic

<p align="center">
  <img src="https://user-images.githubusercontent.com/47301282/120885521-18ea2180-c607-11eb-92c4-45e3318b0f92.png" alt="Widgets"/>
</p>

1. `MaterialApp:`

   In most apps, MaterialApp is the root widget. It takes care of a lot of the “behind-the-scenes” work for your app. Allows you to set a global theme for your application. Also configures your app's navigation behaviour (e.g. animations).

2. `Scaffold:`

   It serves as a background, app bar, navigation tabs, and other features for a page in your app. It is used as a frame for a page in your app.
   Note: Each page should only have one scaffold.

3. `Container:`

   A convenience widget that combines common painting, positioning, and sizing widgets.

4. `Row / Column:`

   The two most significant and powerful widgets in Flutter are Row and Column. These widgets allow you to arrange children horizontally and vertically as needed.

5. `Stack:`

   It's used to stack objects on top of one another (along the Z axis).

6. `ListView and GridView:`

   It's used to create item lists (or grids). It's similar to Column(), but it's scrollable.

7. `Text, Image, Icon:`

   Text is a widget that simply outputs some text on the screen. Image widget is used to render an image on the screen. Icon widget renders an Icon onto the screen.

8. `TextField, RaisedButton / FlatButton / IconButton, GestureDetector / InkWell:`

   TextField Creates a user-editable text field. User taps are handled by different-styled buttons (RaisedButton / FlatButton / IconButton). GestureDetector wraps ANY widget with touch listeners (e.g. double tap, long tap), whereas InkWell does the same but adds a visual ripple effect to touches.

Explore more about widgets on [flutter.dev](https://flutter.dev/docs/development/ui/widgets).

<p align="center">
  <img src="https://user-images.githubusercontent.com/47301282/120885520-18518b00-c607-11eb-8e1f-5c816d1fb292.png" alt="styling"/>
</p>

- Basic terms for styling:

<p align="center">
  <img src="https://user-images.githubusercontent.com/47301282/120882438-a0c73000-c5f5-11eb-81e9-3bd099f4e7d7.png" alt="padding margin border"/>
</p>

1. **Content** - Box content where text and pictures are shown.

2. **Padding** - Clears an area around the content. The padding is transparent.

3. **Border** - A border that goes around the padding and content.

4. **Margin** - Clears an area outside the border. The margin is transparent.

- `Center` Widget

<p align="center">
  <img src="https://user-images.githubusercontent.com/47301282/120882490-ea177f80-c5f5-11eb-8cb3-4988edd94d84.png" alt="center"/>
</p>

```
Center(
  child: Container(
    color: Colors.green,
    child: Text("Center"),
  ),
);
```

- `Colors` Class

  - You can use the color property to apply a color.

- `Color` Class

  - You can use the Color(0xFFFFFFFF) (8 hexadecimal digits to specify color); .fromARGB (A = Alpha or opacity, R = Red, G = Green, B = Blue); .fromRGBO (R = Red, G = Green, B = Blue, O = Opacity).

- `Container` Widget

  - is used to contain a child widget with the ability to apply some styling properties.

  - Alignment Property

    - We use an Alignment Class with the alignment property to be applied for aligning the child widgets.

<p align="center">
  <img src="https://user-images.githubusercontent.com/47301282/120882574-4ed2da00-c5f6-11eb-8f31-d9b3b93c13fe.jpeg" alt="alignment scale"/>
</p>

    - Alignment take 2 parameters x and y. Alignment(0.0, 0.0)

    ```
    Container(
      color: Color.fromARGB(255, 66, 165, 245),
      child: new Text(
        "Alignment",
        style: TextStyle(fontSize: 25.0),
      ),
      alignment: Alignment(0.0, 0.0),
    );
    ```

    - Alignment(-1.0, -1.0) represents the top left of the rectangle.

<p align="center">
  <img src="https://user-images.githubusercontent.com/47301282/120882491-eb48ac80-c5f5-11eb-8ee5-f5dd9bfca917.png" alt="alignment"/>
</p>

- Margin property

  - add empty space to surround of the container.

  ```
  Container(
    color: Colors.green,
    child: Container(
       color: Colors.purple,
       margin: new EdgeInsets.all(40.0),
    ),
  )
  ```

<p align="center">
  <img src="https://user-images.githubusercontent.com/47301282/120882493-ebe14300-c5f5-11eb-9c93-98c02df1adf1.png" alt="Margin"/>
</p>

- EdgeInsets.all() if you need to add margin on all sides.

- EdgeInsets.symmetric() if you need to add margin with symmetrical vertical and/or horizontal offsets.

- Padding property

  - EdgeInsets works same for padding.

  ```
  Container(
    color: Colors.blueAccent,
    padding: new EdgeInsets.all(40.0),
    child: Container(
      color: Colors.purple,
      child: Text('Padding'),
    ),
  )
  ```

<p align="center">
  <img src="https://user-images.githubusercontent.com/47301282/120882494-ec79d980-c5f5-11eb-9d02-6ce1cfb1080f.png" alt="Margin"/>
</p>

<p align="center">
  <img src="https://user-images.githubusercontent.com/47301282/120885517-17205e00-c607-11eb-8233-f54d5a9ba94e.png" alt="Logic"/>
</p>

1. Styling

We have to design a card as shown below.

Break down the components and construct a widget tree according to it, then construct preliminary structure of widgets.
After that Style the components. Wrap a component with Container for enhanced styling.

<p align="center">
  <img src="https://user-images.githubusercontent.com/47301282/120883450-de7a8780-c5fa-11eb-829d-cd29e5315c9e.png" alt="how to style"/>
</p>

<p align="center">
  <img src="https://user-images.githubusercontent.com/47301282/120884629-c0645580-c601-11eb-806c-bd213afda915.png" alt="tree"/>
</p>

2. Workflow (how an app should behave?)

- Every project begins with a plan. Start by listing all your applications' services.
- Then start designing the services with naivety. Concentrate on what this page, action, button, etc. is going to do (ex. when users wish to do 2+2, the app should then get inputs and provide an output).
