import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/product_model.dart';
import '../../domain/usecases/product_usecase.dart';
enum SortType { none, priceLowToHigh, priceHighToLow, rating }

class ProductNotifier extends Notifier<BaseState> {
  late final ProductUseCases productUseCases;
  final ScrollController scrollController = ScrollController();

  List<ProductModel> allProducts = [];
  List<ProductModel> filteredProducts = [];
  List<ProductModel> visibleProducts = [];

  //int limitData = 5;
  String currentQuery = '';
  SortType currentSort = SortType.none;

  @override
  BaseState build() {
    productUseCases = ref.read(productUseCaseProvider);
    scrollController.addListener(_scrollListener);
    return BaseState();
  }

  Future<void> fetchFeaturedProduct() async {
    state = state.copyWith(status: Status.loading);
    final (error, products) = await productUseCases.productList();
    if (error != null) {
      state = state.copyWith(status: Status.error, message: error.message);
    } else {
      allProducts = products!;
      //limitData = 5;
      applySearchAndSort(); // applies filtering + pagination
    }
  }

  void search(String query) {
    currentQuery = query;
    //limitData = 5;
    applySearchAndSort();
  }

  void sort(SortType sortType) {
    currentSort = sortType;
    //limitData = 5;
    applySearchAndSort();
  }

  void applySearchAndSort() {
    List<ProductModel> temp = [...allProducts];

    if (currentQuery.isNotEmpty) {
      temp = temp
          .where((e) => e.title.toLowerCase().contains(currentQuery.toLowerCase()))
          .toList();
    }

    switch (currentSort) {
      case SortType.priceLowToHigh:
        temp.sort((a, b) => a.price.compareTo(b.price));
        break;
      case SortType.priceHighToLow:
        temp.sort((a, b) => b.price.compareTo(a.price));
        break;
      case SortType.rating:
        temp.sort((a, b) => b.rating.rate.compareTo(a.rating.rate));
        break;
      default:
        break;
    }

    filteredProducts = temp;
    _updateVisibleProducts();
  }

  void _updateVisibleProducts() {
    visibleProducts = filteredProducts.take(20).toList();
    state = state.copyWith(status: Status.success, data: visibleProducts);
  }

  bool isLoadingMore = false;

  void _scrollListener() async {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      if (!isLoadingMore) {
        isLoadingMore = true;

        // Simulate network delay (optional)
        await Future.delayed(const Duration(seconds: 1));

       // limitData += 5;
        _updateVisibleProducts();

        isLoadingMore = false;
      }
    }
  }

}
