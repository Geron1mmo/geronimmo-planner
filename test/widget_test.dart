import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geronimmo_planner/app.dart';

void main() {
  testWidgets('App loads dashboard tab', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: GeronimmoPlannerApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(MaterialApp), findsOneWidget);
  });
}