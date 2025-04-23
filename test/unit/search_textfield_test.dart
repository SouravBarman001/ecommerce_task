

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ecommerce_task/main.dart'; // adjust this if needed


final searchTextProvider = StateProvider<String>((ref) => '');

void main() {
  testWidgets('TextField updates searchTextProvider on input', (WidgetTester tester) async {

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: Consumer(
              builder: (context, ref, _) {
                final searchText = ref.watch(searchTextProvider);
                return Column(
                  children: [
                    TextField(
                      key: const Key('search_field'),
                      onChanged: (value) {
                        ref.read(searchTextProvider.notifier).state = value;
                      },
                      decoration: const InputDecoration(
                        hintText: "Search Anything...",
                      ),
                    ),
                    Text('Current: $searchText', key: const Key('output')),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );

    // Initial state should be empty
    expect(find.text('Current: '), findsOneWidget);


    await tester.enterText(find.byKey(const Key('search_field')), 'Shoes');
    await tester.pump();

    // Check if the state updated and text is shown
    expect(find.text('Current: Shoes'), findsOneWidget);
  });
}
