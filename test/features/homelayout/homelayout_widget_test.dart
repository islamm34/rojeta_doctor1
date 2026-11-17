// Widget test for homelayout navigation bar.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:rojeta_doctor/l10n/app_localizations.dart';
import 'package:rojeta_doctor/shared/widgets/custom_nav_bar.dart';

void main() {
  testWidgets('CustomBottomNavBar renders navigation items and handles selection', (tester) async {
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
                badgeCount: 5,
              ),
            );
          },
        ),
      ),
    );

    expect(find.byType(CustomBottomNavBar), findsOneWidget);
    expect(find.byIcon(Icons.home), findsOneWidget);
    expect(find.byIcon(Icons.calendar_today_outlined), findsOneWidget);
    expect(find.byIcon(Icons.notifications_none_outlined), findsOneWidget);
    expect(find.byIcon(Icons.settings_outlined), findsOneWidget);
    expect(find.text('5'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.calendar_today_outlined));
    await tester.pump();

    expect(selected, 1);
  });
}
