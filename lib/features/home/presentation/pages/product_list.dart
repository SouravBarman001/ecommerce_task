import 'package:ecommerce_task/features/home/data/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:core/core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../riverpod/product_list_notifier.dart';
import '../riverpod/product_provider.dart';
import '../riverpod/search_text_provider.dart';



class ProductList extends ConsumerStatefulWidget {
  const ProductList({super.key});

  @override
  ConsumerState<ProductList> createState() => _ProductListState();
}

class _ProductListState extends ConsumerState<ProductList> {
  @override
  void initState() {
    super.initState();
    Future(() {
      ref.read(productNotifierProvider.notifier).fetchFeaturedProduct();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(productNotifierProvider);
    final searchText = ref.watch(searchTextProvider);
    final products = ref.watch(productProvider);

    // Count matching items
    final filteredProductsCount = products.length;

    final productState = ref.watch(productNotifierProvider);

    if (productState.status == Status.loading) {
      return const Center(child: CircularProgressIndicator());
    } else if (productState.status == Status.success) {
      final products = productState.data as List<ProductModel>;

      return Padding(
        padding: EdgeInsets.all(12.0.w),
        child: GridView.builder(
          controller: ref.read(productNotifierProvider.notifier).scrollController,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(
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
                          product.image,
                          height: 140.h,
                          width: double.infinity,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Positioned(
                        top: 8.h,
                        right: 8.w,
                        child: const Icon(
                          true
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: true
                              ? Colors.red
                              : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0.w),
                    child: Text(
                      product.title,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: 8.0.w),
                    child: Row(
                      children: [
                        Text(
                          "\$${product.price}",
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          "\$${150}",
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey,
                            decoration:
                            TextDecoration.lineThrough,
                          ),
                        ),
                        SizedBox(width: 3.w),
                        Text(
                          "{20% OFF}",
                          style: TextStyle(
                              fontSize: 7.sp,
                              color: Colors.orange),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0.w),
                    child: Row(
                      children: [
                        Icon(Icons.star,
                            size: 16.sp, color: Colors.amber),
                        SizedBox(width: 4.w),
                        Text(
                          product.rating.rate.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp),
                        ),
                        Text(
                          " (${product.rating.count})",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12.sp),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    }
    else{
      return Padding(
        padding: EdgeInsets.all(16.0.w),
        child: Text(
          state.message ?? 'An error occurred',
          style: TextStyle(fontSize: 16.sp, color: Colors.red),
        ),
      );
    }

  }
}