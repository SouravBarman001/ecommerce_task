

import 'package:flutter_test/flutter_test.dart';
import 'package:ecommerce_task/features/home/data/models/product_model.dart';

void main() {
  group('ProductModel Validation', () {
    test('Product price should be a non-zero double and not null', () {
      final product = ProductModel(
        id: 1,
        title: 'Stylish Sneakers',
        price: 59.99,
        description: 'Comfortable and stylish sneakers.',
        category: 'Shoes',
        image: 'https://example.com/image.png',
        rating: Rating(rate: 4.5, count: 300),
      );

      expect(product.price, isNotNull);
      expect(product.price, isA<double>());
      expect(product.price, greaterThan(0));
    });

    test('Product title should not exceed 3 lines worth of characters (~150)', () {
      final product = ProductModel(
        id: 2,
        title: 'This is a very long product title that might take up more than three lines in a mobile UI layout, depending on screen size and font. It should be trimmed.',
        price: 49.99,
        description: 'Oversized hoodie.',
        category: 'Clothing',
        image: 'https://example.com/image.png',
        rating: Rating(rate: 4.8, count: 120),
      );

      // Roughly estimate 3 lines worth of text (e.g. 150 characters)
      expect(product.title.length <= 150, isTrue);
    });

    test('Product title should not contain special symbols', () {
      final product = ProductModel(
        id: 3,
        title: 'Cool Shoes! @50% Off!!!', // contains invalid characters
        price: 0,
        description: 'Invalid title',
        category: 'Shoes',
        image: 'https://example.com/image.png',
        rating: Rating(rate: 3.5, count: 55),
      );

      final specialSymbolRegex = RegExp(r'[!@#\$%^&*(),.?":{}|<>]');
      expect(specialSymbolRegex.hasMatch(product.title), isFalse, reason: 'Title contains special characters');
    });
  });
}
