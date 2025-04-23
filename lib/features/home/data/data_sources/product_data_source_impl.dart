import 'package:core/core.dart';

import 'product_data_scource.dart';

class ProductDataSourceImpl implements ProductDataSource {
  ProductDataSourceImpl({
    required this.client,
  });

  final RestClient client;

  @override
  Future<Response> featuredItems() async {
    final response = await client.get(
      APIType.public,
      API.allProducts,
    );
    return response;
  }

  @override
  Future<Response> limitItems(int limit) async {
    final response = await client.get(
      APIType.public,
      '/products?limit=$limit',
    );
    return response;
  }
}