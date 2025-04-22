import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // iPhone X design size
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) => MaterialApp(
        theme: ThemeData(
          fontFamily: 'Inter',
        ),
        debugShowCheckedModeBanner: false,
        home: const SafeArea(child: ProductCardScroll()),
      ),
    );
  }
}

// Provider for search text state
final searchTextProvider = StateProvider<String>((ref) => '');

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


class ProductCardScroll extends ConsumerWidget {
  const ProductCardScroll({super.key});

  void _showFilterBottomSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16.0.w),
          height: 270.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: Text('Sort By', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
                trailing: IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
              ),
              ListTile(
                title: Text('Price - High to Low', style: TextStyle(fontSize: 14.sp)),
                onTap: () {
                  ref.read(productProvider.notifier).updateSortType('priceHighToLow');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Price - Low to High', style: TextStyle(fontSize: 14.sp)),
                onTap: () {
                  ref.read(productProvider.notifier).updateSortType('priceLowToHigh');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Rating', style: TextStyle(fontSize: 14.sp)),
                onTap: () {
                  ref.read(productProvider.notifier).updateSortType('rating');
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchText = ref.watch(searchTextProvider);
    final products = ref.watch(productProvider);

    // Count matching items
    final filteredProductsCount = products.length;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: searchText.isNotEmpty ? 135.h : 90.h,
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.all(16.0.w),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            onChanged: (value) {
                              ref.read(searchTextProvider.notifier).state = value;
                              ref.read(productProvider.notifier).filterAndSearch(value);
                            },
                            decoration: InputDecoration(
                              hintText: "Search Anything...",
                              prefixIcon: const Icon(Icons.search),
                              contentPadding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.r),
                                borderSide: const BorderSide(color: Colors.grey),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        if (searchText.isNotEmpty)
                          GestureDetector(
                            onTap: () => _showFilterBottomSheet(context, ref),
                            child: Icon(Icons.sort, size: 28.sp),
                          ),
                      ],
                    ),
                    if (searchText.isNotEmpty)
                      Visibility(
                        visible: filteredProductsCount > 0,
                        child: Container(
                          color: const Color(0xF9FAFB),
                          height: 34.h,
                          margin: EdgeInsets.only(top: 10.h),
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: Text(
                            "$filteredProductsCount Items",
                            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12.0.w),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12.w,
                  mainAxisSpacing: 1.h,
                  childAspectRatio: 0.66,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return Card(
                    color: Colors.white54,
                    elevation: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5.r),
                                topRight: Radius.circular(5.r),
                              ),
                              child: Image.network(
                                product['image'],
                                height: 140.h,
                                width: double.infinity,
                                fit: BoxFit.contain,
                              ),
                            ),
                            Positioned(
                              top: 8.h,
                              right: 8.w,
                              child: Icon(
                                product['isFavorite'] ? Icons.favorite : Icons.favorite_border,
                                color: product['isFavorite'] ? Colors.red : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0.w),
                          child: Text(
                            product['name'],
                            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                          child: Row(
                            children: [
                              Text(
                                "\$${product['price']}",
                                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 5.w),
                              Text(
                                "\$${product['oldPrice']}",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                              SizedBox(width: 3.w),
                              Text(
                                product['discount'],
                                style: TextStyle(fontSize: 12.sp, color: Colors.orange),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0.w),
                          child: Row(
                            children: [
                              Icon(Icons.star, size: 16.sp, color: Colors.amber),
                              SizedBox(width: 4.w),
                              Text(
                                product['rating'].toString(),
                                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12.sp),
                              ),
                              Text(
                                " (${product['reviews']})",
                                style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            // Pagination mock
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: ElevatedButton(
                onPressed: () {
                  // Load more products (pagination)
                  ref.read(productProvider.notifier).loadSortedProducts();
                },
                child: const Text('Load More'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



