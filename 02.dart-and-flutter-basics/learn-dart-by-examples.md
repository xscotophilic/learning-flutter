# Learn Dart by Examples

This isn't just a list of code snippets. It's a sequence designed to help you think like a Dart developer. Use this guide alongside [DartPad](https://dartpad.dev/) to see the code in action.

---

## 🚀 1. The Entry Point: Hello World

Every Dart program starts at the `main()` function. This is where the execution begins.

```dart
void main() {
  print('Hello, Flutter Developer!');
}
```

---

## 📦 2. Variables and Sound Null Safety

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
> **Sound Null Safety**: By default, variables cannot be `null`. If you want to allow null, use a `?` (e.g., `String? middleName`). This prevents the most common crashes in mobile apps!

---

## ⚙️ 3. Functions: Building Logic

Functions in Dart are "first-class," meaning they are objects themselves.

```dart
// A function that takes two numbers and returns their sum
// We use 'num' to allow both 'int' and 'double'
num add(num a, num b) => a + b; // Shorthand "fat arrow" syntax

void main() {
  var result = add(10, 5.5);
  print('The sum is: $result');
}
```

---

## 🏗️ 4. Object-Oriented Dart (Classes)

Classes are the blueprints for everything you build in Flutter.

```dart
class User {
  final String name;
  final int id;

  // Modern Dart Constructor: Clean and concise
  User({required this.name, required this.id});

  void greet() {
    print('Hello, my name is $name (ID: $id)');
  }
}

void main() {
  // Creating an instance using named parameters (standard in Flutter)
  final user = User(name: 'Bob', id: 42);
  user.greet();
}
```

> [!TIP]
> Notice the `{}` in the constructor? These are **named parameters**. In Flutter, widgets use these almost exclusively because they make the code much more readable.

---

## 🌳 5. Inheritance and Mixins

As your app grows, you'll need to share behavior between classes.

```dart
abstract class Animal {
  void eat() => print('Eating...');
}

class Bird extends Animal {
  void fly() => print('Flying high!');
}

void main() {
  final parrot = Bird();
  parrot.eat(); // Inherited from Animal
  parrot.fly(); // Defined in Bird
}
```

---

## 🏁 Next Steps

Now that you have the syntax down, you're ready to see how these concepts are used in a real app.

👉 **[Head back to the README](README.md)** to see how we use these classes to build the **Quiz App**.

### Classes and Inheritance (The "Blueprint" Concept)

Think of a **Class** as a blueprint. If you define a `Dog` class, you're saying "all dogs have a name and can bark." **Inheritance** lets you create specialized blueprints (like `GoldenRetriever`) based on the general one, saving you from writing the same code twice.
