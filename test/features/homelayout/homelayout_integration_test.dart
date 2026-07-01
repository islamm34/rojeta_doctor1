// Integration test skeleton for the feature.

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rojeta_doctor/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Load feature end-to-end', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    expect(find.text('Data Loaded ✅'), findsOneWidget);
  });
}
