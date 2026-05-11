import 'package:flutter/material.dart';
import '../domain/product_service.dart';
import '../domain/product_model.dart';

class ProductProvider extends ChangeNotifier {
  final ProductService _service = ProductService();

  List<Product> products = [];
  bool isLoading = false;
  String? error;

  Future<void> fetchProducts() async {
    try {
      isLoading = true;
      notifyListeners();

      products = await _service.getProducts();

      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      error = e.toString();
      notifyListeners();
    }
  }
}
