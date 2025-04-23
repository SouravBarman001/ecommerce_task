import 'package:core/core.dart';
import 'package:ecommerce_task/features/home/presentation/pages/product_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../riverpod/product_provider.dart';

import '../riverpod/search_text_provider.dart';
import '../widgets/helper/bottom_sheet_helper.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    Future(() {
      ref.read(cacheServiceProvider).init();
    });
    Future(() {
      ref.read(productNotifierProvider.notifier).fetchFeaturedProduct();
    });
  }

  @override
  Widget build(BuildContext context) {


    final state = ref.watch(productNotifierProvider);

    final productList = ref.watch(productNotifierProvider).data ?? [];
    final filteredProductsCount = productList.length;

    final searchText = ref.watch(searchTextProvider);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: (searchText.isNotEmpty  && filteredProductsCount > 0) ? 145.h : 90.h,
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
                              ref.read(productNotifierProvider.notifier).search(value);
                            },
                            decoration: InputDecoration(
                              hintText: "Search Anything...",
                              prefixIcon: const Icon(Icons.search),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 15.h, horizontal: 20.w),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.r),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        if (searchText.isNotEmpty)
                          GestureDetector(
                            onTap: () =>
                                BottomSheetHelper.showFilterBottomSheet(
                                    context, ref),
                            child: Icon(Icons.sort, size: 28.sp),
                          ),
                      ],
                    ),
                    if (filteredProductsCount > 0)
                      Visibility(
                        visible: searchText.isNotEmpty,
                        child: Container(
                          color: const Color(0xF9FAFB),
                          height: 34.h,
                          margin: EdgeInsets.only(top: 10.h),
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: Text(
                            "$filteredProductsCount Items",
                            style: TextStyle(
                                fontSize: 12.sp, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),

            const ProductList(),


          ],
        ),
      ),
    );
  }
}
