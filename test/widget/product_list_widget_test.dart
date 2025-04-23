import 'package:ecommerce_task/features/home/data/models/product_model.dart';
import 'package:ecommerce_task/features/home/presentation/pages/product_list.dart';

import 'package:ecommerce_task/features/home/presentation/riverpod/product_notifier.dart';
import 'package:core/core.dart';
import 'package:ecommerce_task/features/home/presentation/riverpod/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class MockProductNotifier extends ProductNotifier {
  MockProductNotifier() {
    allProducts = [
      ProductModel(
        id: 1,
        title: 'Running Shoes for Men',
        price: 99.99,
        description: 'High quality running shoes.',
        category: 'Shoes',
        image: 'https://example.com/shoe.png',
        rating: Rating(rate: 4.5, count: 100),
      ),
      ProductModel(
        id: 2,
        title: 'Invalid#Title@With!Symbols',
        price: 0.0,
        description: 'Test product',
        category: 'Test',
        image: 'https://example.com/image.png',
        rating: Rating(rate: 4.0, count: 50),
      ),
    ];
    filteredProducts = allProducts;
    visibleProducts = filteredProducts;
    state = BaseState(status: Status.success, data: visibleProducts);
  }

  @override
  Future<void> fetchFeaturedProduct() async {
    // skip API call
  }
}

void main() {
  testWidgets('ProductList renders valid products and checks content rules', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          productNotifierProvider.overrideWith(() => MockProductNotifier()),
        ],
        child: const MaterialApp(
          home: Scaffold(
            body: ProductList(),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Check that product cards are rendered
    expect(find.byType(Card), findsNWidgets(2));

    // Get all text widgets (titles)
    final titleWidgets = tester.widgetList<Text>(
      find.descendant(of: find.byType(Card), matching: find.byType(Text)),
    ).where((text) => text.data != null && text.data!.contains('Shoes'));

    for (final textWidget in titleWidgets) {
      final text = textWidget.data!;
      // Check title character limit (~150 chars ~ 3 lines)
      expect(text.length <= 150, isTrue, reason: 'Title exceeds 3 line limit');

      // Check for special characters
      final hasSpecialChars = RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(text);
      expect(hasSpecialChars, isFalse, reason: 'Title contains special characters');
    }

    // Check product price (should be > 0 for the valid one)
    final mockNotifier = MockProductNotifier();
    for (final product in mockNotifier.visibleProducts) {
      expect(product.price, greaterThan(0), reason: 'Product price must be greater than 0');
    }
  });
}
