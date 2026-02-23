import 'package:flutter_test/flutter_test.dart';

import 'package:quizapp/main.dart';

void main() {
  testWidgets('Smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Quiz App'), findsOneWidget);
  });
}
