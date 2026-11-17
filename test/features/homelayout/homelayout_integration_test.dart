// Integration test skeleton for homelayout navigation.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:rojeta_doctor/l10n/app_localizations.dart';
import 'package:rojeta_doctor/shared/widgets/custom_nav_bar.dart';

void main() {
  testWidgets('Load homelayout nav bar end-to-end', (tester) async {
    int selected = 0;

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('en'),
        home: StatefulBuilder(
          builder: (context, setState) {
            return Scaffold(
              bottomNavigationBar: CustomBottomNavBar(
                selectedIndex: selected,
                onDestinationSelected: (index) {
                  setState(() {
                    selected = index;
                  });
                },
              ),
            );
          },
        ),
      ),
    );

    expect(find.byType(CustomBottomNavBar), findsOneWidget);
    await tester.tap(find.byIcon(Icons.settings_outlined));
    await tester.pump();
    expect(selected, 3);
  });
}
