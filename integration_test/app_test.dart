import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:smart_notes_app/main.dart' as app;

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Capture Screenshots', (WidgetTester tester) async {
    // 1. Launch App
    app.main();
    await tester.pumpAndSettle();

    // Skip splash screen (3 seconds + animations)
    await Future.delayed(const Duration(seconds: 4));
    await tester.pumpAndSettle();

    // 2. Capture Home Screen
    await binding.takeScreenshot('home');

    // 3. Open Add Note Screen
    final fab = find.byType(FloatingActionButton);
    await tester.tap(fab);
    await tester.pumpAndSettle();
    await binding.takeScreenshot('add_note');

    // 4. Fill Add Note Form
    await tester.enterText(find.byType(TextField).at(0), 'Test Note Title');
    await tester.enterText(find.byType(TextField).at(1), 'This is a test note content for the screenshot.');
    await tester.pumpAndSettle();

    // 5. Save Note
    await tester.tap(find.text('Add'));
    await tester.pumpAndSettle();

    // 6. Open Edit Note Screen
    await tester.tap(find.text('Test Note Title'));
    await tester.pumpAndSettle();
    await binding.takeScreenshot('edit');

    // 7. Close Dialog
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    // 8. Capture Delete Confirmation
    await tester.tap(find.byIcon(Icons.delete_outline));
    await tester.pumpAndSettle();
    await binding.takeScreenshot('delete');
  });
}
