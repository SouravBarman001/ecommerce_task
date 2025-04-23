import 'package:core/core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/product_model.dart';
import '../repositories/product_repo.dart';

final featuredUseCaseProvider = Provider<FeaturedProductUseCases>(
      (ref) => FeaturedProductUseCases(
    featuredRepo: ref.watch(productRepoProvider),
  ),
);

class FeaturedProductUseCases {
  FeaturedProductUseCases({
    required this.featuredRepo,
  });

  final ProductRepo featuredRepo;

  Future<(ErrorModel?, List<ProductModel>?)> productList() async {
    final response = await featuredRepo.Products();
    return response;
  }

  Future<(ErrorModel?, List<ProductModel>?)> limitProductList(
      int limit,) async {
    final response = await featuredRepo.limitFeaturedProducts(limit);
    return response;
  }
}