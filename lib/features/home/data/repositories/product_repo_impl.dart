import 'package:core/core.dart';

import '../../domain/repositories/product_repo.dart';
import '../data_sources/product_data_scource.dart';
import '../models/product_model.dart';

class ProductRepoImpl implements ProductRepo {
  ProductRepoImpl({
    required this.productDataSource,
  });

  ProductDataSource productDataSource;

  @override
  Future<(ErrorModel?, List<ProductModel>?)> Products() async {
    return productDataSource.featuredItems().guard(
          (data) {
        final featuredModels = List<ProductModel>.from(
          (data as List).map(
                (item) => ProductModel.fromJson(item),
          ),
        );

        return featuredModels;
      },
    );
  }

  @override
  Future<(ErrorModel?, List<ProductModel>?)> limitFeaturedProducts(
      int limit,
      ) async {
    return productDataSource.limitItems(limit).guard(
          (data) {
        final featuredModels = List<ProductModel>.from(
          (data as List).map(
                (item) => ProductModel.fromJson(item),
          ),
        );

        return featuredModels;
      },
    );
  }
}