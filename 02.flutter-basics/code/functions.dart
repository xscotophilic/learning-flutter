// learn OOPs concepts first
// Go to https://dartpad.dev/ to run the program

int addTwoInts(int num1, int num2) {
  return num1 + num2;
}

num addTwoNumbers(num num1, num num2) {
  return num1 + num2;
}

void main() {
  // one int, 1 double
  print('Adding two numbers version1: ${addTwoNumbers(2, 3.5)}');
  print('Adding two numbers version2: ${addTwoNumbers(2.5, 3)}');
  // 2 double
  print('Adding two numbers version3: ${addTwoNumbers(2.5, 3.5)}');
  // 2 ints
  print('Adding two numbers version4: ${addTwoNumbers(2, 3)}');
  // 2 intergers strictly
  print('\nAdding two intergers strictly: ${addTwoInts(2, 3)}');
}
