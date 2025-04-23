import 'package:core/core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/product_model.dart';
import '../repositories/product_repo.dart';

final productUseCaseProvider = Provider<ProductUseCases>(
      (ref) => ProductUseCases(
    productRepo: ref.watch(productRepoProvider),
  ),
);

class ProductUseCases {
  ProductUseCases({
    required this.productRepo,
  });

  final ProductRepo productRepo;

  Future<(ErrorModel?, List<ProductModel>?)> productList() async {
    final response = await productRepo.products();
    return response;
  }

  Future<(ErrorModel?, List<ProductModel>?)> limitProductList(
      int limit,) async {
    final response = await productRepo.limitFeaturedProducts(limit);
    return response;
  }
}