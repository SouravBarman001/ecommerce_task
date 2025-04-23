
import 'package:flutter_riverpod/flutter_riverpod.dart';



// Provider for paginated products
final productProvider = StateNotifierProvider<ProductListNotifier, List<Map<String, dynamic>>>(
      (ref) => ProductListNotifier(),
);


class ProductListNotifier extends StateNotifier<List<Map<String, dynamic>>> {
  ProductListNotifier() : super([]);

  final List<Map<String, dynamic>> _allProducts = const [
    {
      'image': 'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg',
      'name': 'Allen Solly Regular fit cotton shirt',
      'price': 35,
      'oldPrice': 40.25,
      'discount': '15% OFF',
      'rating': 4.3,
      'reviews': 41,
      'isFavorite': true,
    },
    {
      'image': 'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg',
      'name': 'Calvin Clein Regular fit slim fit shirt',
      'price': 52,
      'oldPrice': 62.4,
      'discount': '20% OFF',
      'rating': 4.1,
      'reviews': 87,
      'isFavorite': false,
    },
    {
      'image': 'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg',
      'name': 'Allen Solly Regular fit cotton shirt',
      'price': 35,
      'oldPrice': 40.25,
      'discount': '15% OFF',
      'rating': 4.3,
      'reviews': 41,
      'isFavorite': true,
    },
    {
      'image': 'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg',
      'name': 'Calvin Clein Regular fit slim fit shirt',
      'price': 52,
      'oldPrice': 62.4,
      'discount': '20% OFF',
      'rating': 4.1,
      'reviews': 87,
      'isFavorite': false,
    },
    {
      'image': 'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg',
      'name': 'Allen Solly Regular fit cotton shirt',
      'price': 35,
      'oldPrice': 40.25,
      'discount': '15% OFF',
      'rating': 4.3,
      'reviews': 41,
      'isFavorite': true,
    },
    {
      'image': 'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg',
      'name': 'Calvin Clein Regular fit slim fit shirt',
      'price': 52,
      'oldPrice': 62.4,
      'discount': '20% OFF',
      'rating': 4.1,
      'reviews': 87,
      'isFavorite': false,
    },
    {
      'image': 'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg',
      'name': 'Allen Solly Regular fit cotton shirt',
      'price': 35,
      'oldPrice': 40.25,
      'discount': '15% OFF',
      'rating': 4.3,
      'reviews': 41,
      'isFavorite': true,
    },
    {
      'image': 'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg',
      'name': 'Calvin Clein Regular fit slim fit shirt',
      'price': 52,
      'oldPrice': 62.4,
      'discount': '20% OFF',
      'rating': 4.1,
      'reviews': 87,
      'isFavorite': false,
    },
  ];

  // Store the current sorting type
  String sortType = 'priceLowToHigh';

  // Function to update products based on sorting
  void loadSortedProducts() {
    List<Map<String, dynamic>> sortedProducts = List.from(_allProducts);

    // Sorting logic
    if (sortType == 'priceLowToHigh') {
      sortedProducts.sort((a, b) => a['price'].compareTo(b['price']));
    } else if (sortType == 'priceHighToLow') {
      sortedProducts.sort((a, b) => b['price'].compareTo(a['price']));
    } else if (sortType == 'rating') {
      sortedProducts.sort((a, b) => b['rating'].compareTo(a['rating']));
    }

    state = sortedProducts;
  }

  // Function to filter products based on search text
  void filterAndSearch(String searchText) {
    state = _allProducts
        .where((product) =>
        product['name'].toLowerCase().contains(searchText.toLowerCase()))
        .toList();
  }

  // Update sorting type and reload products
  void updateSortType(String newSortType) {
    sortType = newSortType;
    loadSortedProducts();
  }
}