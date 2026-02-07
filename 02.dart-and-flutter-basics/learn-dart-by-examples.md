# Learn Dart by Examples

Use this guide alongside [DartPad](https://dartpad.dev/) to see the code in action.

## 1. Hello World

Every Dart program starts at the `main()` function. This is where the execution begins.

```dart
void main() {
  print('Hello world!');
}
```

## 2. Variables and Sound Null Safety

In modern Dart, we care about **where** data lives and **if** it can be empty.

```dart
void main() {
  // 1. Explicitly typed
  String name = "Alice";

  // 2. Type Inference (Common in Flutter)
  var age = 25; // Dart knows this is an int

  // 3. Immutability (Best Practice)
  // Use 'final' if you'll set it once. Use 'const' for compile-time constants.
  final currentYear = 2024;
  const pi = 3.14159;

  print('Name: $name, Age: $age, Year: $currentYear');
}
```

> [!IMPORTANT]
> **Sound Null Safety**: By default, variables cannot be `null`. If you want to allow null, use a `?` (e.g., `String? name`). This prevents the most common crashes in mobile apps!

```dart
void main() {
  // Nullable variable
  String? name; // The '?' makes the variable nullable

  // Prints "Name: null"
  print('Name: $name'); // At this point, name is null

  // Assign a value
  name = "Alice";

  // Prints "Name: Alice"
  print('Name: $name'); // Now name has a value

  // make it null again
  name = null;

  // Null-aware operator '??' to provide a default value
  String displayName = name ?? "Bob";
  print('Display name: $displayName'); // displayName will not be null

  // Using null-aware access with a method
  // You can also use null assertion (!) - only safe if you are sure it's not null
  print('Name length: ${name?.length}');
}
```

## 3. Functions

Functions in Dart are "first-class," meaning they are objects themselves.

### Simple Functions

```dart
void main() {
  // Normal function
  String greet(String name) {
    return "Hello, $name!";
  }

  // Arrow function
  String greetArrow(String name) => "Hi, $name!";

  // Demonstration
  print(greet("Alice"));        // Hello, Alice!
  print(greetArrow("Bob"));     // Hi, Bob!
}
```

### Advanced Functions

```dart
void main() {
  // ================ Nullable function ================
  void Function(String)? maybeFunc;

  // Call safely (does nothing because it's null)
  maybeFunc?.call("Charlie");

  // Assign a function
  maybeFunc = (name) => print("Hey $name!");

  // Call again
  maybeFunc("Charlie"); // Hey Charlie!


  // ================ Function reference ================
  void sayBye() => print("Bye!");

  // Create a reference (no parentheses, so function is NOT called)
  var ref = sayBye;

  // At this point, nothing happens because we only have a reference
  // Just mentioning 'ref' or 'sayBye' does NOT call the function
  ref; // Nothing happens
  sayBye; // Nothing happens

  // Call via reference
  ref(); // Bye!
  sayBye(); // Bye!

  // ================ Passing function as argument (callback) ================
  String greet(String name) => "Hello, $name!";

  void apply(String name, String Function(String) func) {
    print(func(name));
  }

  // Use named function, notice we are passing the function name without ()
  // because we are not calling it here, we are just passing the reference
  // It will be called inside the apply function (check definition)
  apply("David", greet); // Hello, David!

  // NOTE: We pass a function reference (without parentheses)
  // because we want it to run later—like when the user clicks a button.
  // If we added (), it would run immediately during compilation, which we don't want.

  // Use anonymous arrow function
  apply("Eve", (n) => n.toUpperCase()); // EVE
}
```

## 4. Object-Oriented Dart (Classes)

In Flutter, **everything** is a widget, and every widget is a **Class**. Classes are the "blueprints" for your UI.

### The Blueprint Analogy

Think of a class as a recipe. The recipe itself isn't a cake, but it tells you exactly how to make one. When you follow the recipe, you create an **Instance** (the actual cake).

```dart
class User {
  // 1. Encapsulation: Use '_' to make variables private to this file
  final int _id; // Private variable
  final String name;

  // 2. Constant Constructor
  // Essential for performance!
  // It allows system to reuse the same object in memory, reducing rebuilds.
  const User({required int id, required this.name}) : _id = id;

  // 3. Named Constructor
  // Great for alternative ways to create data
  User.guest()
    : _id = 0,
      name = "Guest";

  // 4. Factory Constructor
  // The "Smart" Constructor
  // Useful for logic (like JSON parsing) before returning an object.
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] ?? 'Unknown',
      id: json['id'] ?? 0,
    );
  }

  // 5. Getter: Access private data safely
  int get id => _id;

  void greet() => print('Hello, I am $name (ID: $_id)');
}

void main() {
  // Creating a constant instance
  const admin = User(name: 'Alice', id: 1);

  // Using a Named Constructor
  final guest = User.guest();

  // Using a Factory Constructor (simulating an API response)
  final fromApi = User.fromJson({'name': 'Bob', 'id': 42});

  admin.greet();
  guest.greet();
  fromApi.greet();
}
```

> [!TIP]
> **Why `const`?** In Dart and Flutter, you'll often see `const Text('Hello')`. This tells Dart to create that widget once and never "re-render" it if nothing changed. It's a massive performance boost!

## 5. Sharing Behavior: Inheritance, Mixins, and Extensions

As your app grows, you'll want to share code between classes without repeating yourself.

### Inheritance

A `Bird` **is an** `Animal`. It inherits everything the animal can do.

```dart
abstract class Animal {
  void eat() => print('Eating...');
}

class Bird extends Animal {
  void fly() => print('Flying high!');
}
```

### Mixins

Sometimes you want to add a specific "power" to a class without making it a child. This is where **Mixins** shine.

```dart
mixin FlutterDev {
  void code() => print('Writing beautiful UI...');
}

// "with" is the keyword for Mixins
class Human extends Animal with FlutterDev {}

void main() {
  final dev = Human();
  dev.eat();  // From Animal
  dev.code(); // From FlutterDev Mixin
}
```

## 🏁 Next Steps

Now that you've mastered the building blocks of Dart, you're ready to build real apps!

👉 **[Head back to the README](README.md)** to see how we use these classes to build the **Quiz App**.
