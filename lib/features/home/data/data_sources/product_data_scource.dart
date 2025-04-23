import 'package:core/core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'product_data_source_impl.dart';

final productDataResourceProvider = Provider<ProductDataSource>((ref) {
  return ProductDataSourceImpl(client: ref.watch(networkProvider));
});

abstract class ProductDataSource {
  Future<Response> featuredItems();
  Future<Response> limitItems(int limit);
}