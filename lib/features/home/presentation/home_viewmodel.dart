import '../../product/domain/product_model.dart';

class HomeViewModel {
  final List<Product> _products = [
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

  List<Product> get products => _products;

  void addProduct(Product product) {
    _products.add(product);
  }
}
