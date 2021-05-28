## Widgets Cheat sheet:

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
