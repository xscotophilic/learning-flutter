import 'package:flutter_test/flutter_test.dart';
import 'package:my_store/main.dart';

void main() {
  testWidgets('Smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Appetite Assorted'), findsOneWidget);
  });
}
