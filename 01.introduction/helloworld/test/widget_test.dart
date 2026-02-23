import 'package:flutter_test/flutter_test.dart';

import 'package:helloworld/main.dart';

void main() {
  testWidgets('Hello World smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our app does not display 'Goodbye World!'.
    expect(find.text('Goodbye World!'), findsNothing);

    // Verify that our app displays 'Hello World!'.
    expect(find.text('Hello World!'), findsOneWidget);
  });
}
