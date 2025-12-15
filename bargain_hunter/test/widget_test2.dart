import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bargain_hunter/widgets/deal_card.dart';

void main() {
  testWidgets('DealCard displays product info', (tester) async {
    final mockDeal = {
      'title': 'Toothbrush',
      'store': 'Chemist Warehouse',
      'discounted_price': '4.0',
      'original_price': '10.0',
      'end date': DateTime.now().add(const Duration(days: 1)).toIso8601String(),
    };

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DealCard(deal: mockDeal),
        ),
      ),
    );

    expect(find.text('Toothbrush'), findsOneWidget);
    expect(find.text('Chemist Warehouse'), findsOneWidget);
    expect(find.text('\$4.0'), findsOneWidget);
  });
}
