import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/product/domain/product_model.dart';

class ProductListNotifier extends StateNotifier<List<Product>> {
  ProductListNotifier()
    : super([
        Product(
          name: "Laptop",
          price: 10000000,
          description: "A powerful laptop for work and gaming.",
        ),
        Product(
          name: "Mouse",
          price: 200000,
          description: "Wireless mouse with ergonomic design.",
        ),
        Product(
          name: "Keyboard",
          price: 500000,
          description: "Mechanical keyboard with RGB lights.",
        ),
      ]);

  void addProduct(Product product) {
    state = [...state, product];
  }

  void updateProduct(int index, Product product) {
    if (index >= 0 && index < state.length) {
      final newState = List<Product>.from(state);
      newState[index] = product;
      state = newState;
    }
  }

  void removeProduct(int index) {
    if (index >= 0 && index < state.length) {
      final newState = List<Product>.from(state);
      newState.removeAt(index);
      state = newState;
    }
  }

  void reset() {
    state = [
      Product(
        name: "Laptop",
        price: 10000000,
        description: "A powerful laptop for work and gaming.",
      ),
      Product(
        name: "Mouse",
        price: 200000,
        description: "Wireless mouse with ergonomic design.",
      ),
      Product(
        name: "Keyboard",
        price: 500000,
        description: "Mechanical keyboard with RGB lights.",
      ),
    ];
  }
}

final productListProvider =
    StateNotifierProvider<ProductListNotifier, List<Product>>((ref) {
      return ProductListNotifier();
    });
