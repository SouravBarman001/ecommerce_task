import 'package:core/core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/data_sources/product_data_scource.dart';
import '../../data/models/product_model.dart';
import '../../data/repositories/product_repo_impl.dart';

final productRepoProvider = Provider<ProductRepo>((ref) {
  return ProductRepoImpl(
    productDataSource: ref.watch(productDataResourceProvider),
  );
});

abstract class ProductRepo {
  Future<(ErrorModel?, List<ProductModel>?)> Products();
  Future<(ErrorModel?, List<ProductModel>?)> limitFeaturedProducts(int limit);
}
