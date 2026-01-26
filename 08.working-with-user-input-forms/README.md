<p align="center">
  <img src="https://user-images.githubusercontent.com/47301282/123751450-63448280-d8d5-11eb-8be6-4603b8e534f1.png" alt="Working with User Input & Forms"/>
</p>

- Take user input in addition to input widgets in Material Components and Cupertino. TextFields do not have an ID like in Android/ Html, text cannot be retrieved upon demand and must instead be stored in a variable on change or use a controller. You can use forms also.

<img src="https://user-images.githubusercontent.com/47301282/123751440-617abf00-d8d5-11eb-9505-77b3c1578e23.png" alt="Introduction to TextField"/>

- A TextField widget allows collection of information from the user. The code for a basic TextField is as simple as:

```
TextField()
```

- Retrieving information from a TextField

  - The easiest way to do this is to use the onChanged method and store the current value in a simple variable.

    ```
    String username = "";

    TextField(
        onChanged: (userInput) {
            username = userInput;
        },
    )
    ```

  - The second way to do this is to use a TextEditingController.

    ```
    TextEditingController usernameController = TextEditingController();

    TextField(
        controller: usernameController,
    )
    ```

    And get or set values using:

    ```
    print(usernameController.text); // Print current value of
    controller.text = 'Hello World'; // Set new value
    ```

<img src="https://user-images.githubusercontent.com/47301282/123751447-62135580-d8d5-11eb-9131-eae0c10ebf4d.png" alt="Using Forms"/>

- It is mainly used to interact with the app as well as gather information from the users.

- Flutter provides a Form widget to create a form. The form widget acts as a container, which allows us to group and validate the multiple form fields. When you create a form, it is necessary to provide the GlobalKey.

```
final _formKey = GlobalKey<FormState>();

@override
Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
        key: _formKey,
        child: Column(
            children: <Widget>[
            // Add TextFormFields and ElevatedButton here.
            ],
        ),
    );
}

```

- Some more topics to discover:

  1. Working with focus in TextFields

     - Working with autofocus
     - Working with custom focus changes

  2. Changing Keyboard Properties for TextFields

     - Keyboard Type
     - TextInputAction
     - Autocorrect
     - Text Capitalization
     - Text Style, Alignment and Cursor Options

  3. Controlling the Size and Maximum Length in a TextField

     - Making an expandable TextField

  4. Decorating the TextField

---

- You can read about `Working with User Input & Forms` in details on provided links:

  - [A Deep Dive Into Flutter TextField by Deven Joshi](https://medium.com/flutter-community/a-deep-dive-into-flutter-textfields-f0e676aaab7a)
  - [Input widgets by fluter](https://flutter.dev/docs/development/ui/widgets/input)
  - [Build a form with validation by fluter](https://flutter.dev/docs/cookbook/forms/validation)
  - [Flutter Forms by javapoint](https://www.javatpoint.com/flutter-forms)
  - [To create a Beautiful Text Box with in Flutter by Omkar Mestry](https://om-m-mestry.medium.com/to-create-a-beautiful-text-box-with-in-flutter-a7a4d11ae13f)
