import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:bargain_hunter/widgets/filters.dart';
import 'package:bargain_hunter/widgets/filter_provider.dart';

void main() {
  testWidgets('FilterSection renders and toggles filters', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider(
          create: (_) => FilterProvider(),
          child: const Scaffold(body: FilterSection()),
        ),
      ),
    );

    // Verify search field exists
    expect(find.byType(TextField), findsOneWidget);

    // Tap filter icon
    await tester.tap(find.byIcon(Icons.filter_list));
    await tester.pumpAndSettle();

    // Verify dropdown now exists
    expect(find.byType(DropdownButtonFormField<String>), findsOneWidget);
  });
}