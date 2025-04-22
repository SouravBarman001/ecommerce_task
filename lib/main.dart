import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'features/home/presentation/riverpod/text_search_provider.dart';

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

class ProductCardScroll extends ConsumerWidget {
  const ProductCardScroll({super.key});

  final List<Map<String, dynamic>> products = const [
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

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(0.0),
              topRight: Radius.circular(0.0),
            ),
          ),
          padding: EdgeInsets.all(16.0.w),
          height: 270.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: Text(
                  'Sort By',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              ListTile(
                title: Text(
                  'Price - High to Low',
                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
                ),
              ),
              ListTile(
                title: Text(
                  'Price - Low to High',
                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
                ),
              ),
              ListTile(
                title: Text(
                  'Rating',
                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
                ),
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

    return FocusScope(
      onFocusChange: (hasFocus) {
        if (!hasFocus) FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 100.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.0.w),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          onChanged: (value) =>
                          ref.read(searchTextProvider.notifier).state = value,
                          decoration: InputDecoration(
                            hintText: "Search Anything...",
                            prefixIcon: const Icon(Icons.search),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 15.h,
                              horizontal: 20.w,
                            ),
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
                          onTap: () => _showFilterBottomSheet(context),
                          child: Icon(Icons.sort, size: 28.sp),
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
                    mainAxisSpacing: 12.h,
                    childAspectRatio: 0.62,
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
                              )
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
            ],
          ),
        ),
      ),
    );
  }
}