// Widget test skeleton for the feature page.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rojeta_doctor/features/auth/presentation/pages/auth_page.dart';
import 'package:rojeta_doctor/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:rojeta_doctor/core/di/injector.dart' as core_injector;

void main() {
  testWidgets('Shows loading and then loaded text', (tester) async {
    // If you use dependency injection, make sure injector is configured in tests.
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider(
          create: (_) => core_injector.injector<AuthBloc>(),
          child: const AuthPage(),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.text('Data Loaded ✅'), findsOneWidget);
  });
}
