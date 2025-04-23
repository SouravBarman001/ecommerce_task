import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../riverpod/product_list_notifier.dart';
import '../../riverpod/product_notifier.dart';
import '../../riverpod/product_provider.dart';



class BottomSheetHelper {

  BottomSheetHelper.showFilterBottomSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
      ),
      builder: (_) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text(
                "Sort by",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            ListTile(
              title: const Text("Price: Low to High"),
              onTap: () {
                ref.read(productNotifierProvider.notifier)
                    .sort(SortType.priceLowToHigh);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text("Price: High to Low"),
              onTap: () {
                ref.read(productNotifierProvider.notifier)
                    .sort(SortType.priceHighToLow);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text("Rating"),
              onTap: () {
                ref.read(productNotifierProvider.notifier).sort(SortType.rating);
                Navigator.pop(context);
              },
            ),
            SizedBox(height: 10),
          ],
        );
      },
    );
  }


}