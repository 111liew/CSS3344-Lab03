
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:rajang_river_cruise/main.dart';

void main() {
  testWidgets(
    'Rajang River Cruise app displays main screen',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const RajangRiverCruiseApp(),
      );

      expect(
        find.text('Sibu River Cruise & Heritage'),
        findsOneWidget,
      );

      expect(
        find.text('Rajang River Express Cruise'),
        findsOneWidget,
      );

      expect(
        find.byIcon(Icons.star_border),
        findsOneWidget,
      );
    },
  );
}
