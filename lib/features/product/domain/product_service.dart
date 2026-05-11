import 'package:dio/dio.dart';
import 'product_model.dart';

class ProductService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://fakestoreapi.com",
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
    ),
  );

  Future<List<Product>> getProducts() async {
    try {
      final response = await _dio.get("/products");

      final List data = response.data;

      return data.map((e) => Product.fromJson(e)).toList();
    } catch (e) {
      throw Exception("Gagal mengambil data");
    }
  }
}
