import 'package:dio/dio.dart';
import '../core/dio_client.dart';
import '../core/hive_service.dart';
import '../models/product_model.dart';

class ProductRepository {
  final Dio _dio = DioClient.instance;

  Future<List<ProductModel>> fetchProducts({
    required int offset,
    required int limit,
  }) async {
    try {
      final response = await _dio.get(
        'products',
        queryParameters: {
          "offset": offset,
          "limit": limit,
        },
      );

      final data = response.data as List;

      final products =
          data.map((e) => ProductModel.fromJson(e)).toList();

      if (offset == 0) {
        final box = HiveService.getProductBox();
        await box.clear();
        await box.addAll(products);
      }

      return products;
    } catch (e) {
      final box = HiveService.getProductBox();

      if (box.isNotEmpty) {
        return box.values.cast<ProductModel>().toList();
      } else {
        throw Exception("No data");
      }
    }
  }
}