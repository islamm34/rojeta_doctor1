import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rojeta_doctor/features/auth/presentation/widgets/radiology_registeration_flow_pages_widgets/radiology_working_hours_form.dart';
import 'package:rojeta_doctor/l10n/app_localizations.dart';

void main() {
  testWidgets('RadiologyWorkingHoursForm renders and allows time selection without type errors',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: Locale('en'),
        home: Scaffold(
          body: SingleChildScrollView(
            child: RadiologyWorkingHoursForm(),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Verify form renders
    expect(find.byType(RadiologyWorkingHoursForm), findsOneWidget);

    // Find the first "From" or "To" field (Sunday)
    final timeFields = find.byType(InkWell);
    expect(timeFields, findsWidgets);

    // Tap on the first time field
    await tester.tap(timeFields.first);
    await tester.pumpAndSettle();

    // Time picker dialog should appear
    expect(find.byType(TimePickerDialog), findsOneWidget);

    // Tap OK on the time picker
    final okButton = find.text('OK');
    expect(okButton, findsOneWidget);
    await tester.tap(okButton);
    await tester.pumpAndSettle();

    // Time picker is closed, form rebuilds without throwing _TypeError
    expect(tester.takeException(), isNull);
    expect(find.byType(RadiologyWorkingHoursForm), findsOneWidget);
  });

  testWidgets('RadiologyWorkingHoursForm in Arabic locale uses English digits for time',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: Locale('ar'),
        home: Scaffold(
          body: SingleChildScrollView(
            child: RadiologyWorkingHoursForm(),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Find the first "From" or "To" field
    final timeFields = find.byType(InkWell);
    expect(timeFields, findsWidgets);

    // Tap on the first time field
    await tester.tap(timeFields.first);
    await tester.pumpAndSettle();

    // Find the OK/Accept button in Arabic ('موافق' or 'حسناً' or Button)
    final okFinder = find.byType(TextButton).last;
    await tester.tap(okFinder);
    await tester.pumpAndSettle();

    // Verify no Arabic-Indic digits (٠١٢٣٤٥٦٧٨٩) are present in the time fields
    final texts = tester.widgetList<Text>(find.descendant(
      of: find.byType(RadiologyWorkingHoursForm),
      matching: find.byType(Text),
    ));
    final arabicDigitRegex = RegExp(r'[٠-٩]');
    final timeTexts = texts.where((t) => t.data?.contains(':') ?? false);
    for (final t in timeTexts) {
      expect(arabicDigitRegex.hasMatch(t.data ?? ''), isFalse,
          reason: 'Time "${t.data}" should use English digits');
    }
  });
}
