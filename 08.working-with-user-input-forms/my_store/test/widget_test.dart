import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_store/main.dart';

void main() {
  testWidgets('Smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: App()));

    // Wait for splash screen to finish
    await tester.pump(const Duration(seconds: 2));

    expect(find.text('My Store'), findsOneWidget);
  });
}
