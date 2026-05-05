import 'package:flutter_test/flutter_test.dart';
import 'package:my_store/main.dart';

void main() {
  testWidgets('Smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const App());

    expect(find.text('My Store'), findsOneWidget);
  });
}
