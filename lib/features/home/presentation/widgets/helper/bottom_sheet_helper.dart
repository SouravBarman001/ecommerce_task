import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../riverpod/product_list_notifier.dart';



class BottomSheetHelper {
  static void showFilterBottomSheet(BuildContext context, WidgetRef ref) {

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
}