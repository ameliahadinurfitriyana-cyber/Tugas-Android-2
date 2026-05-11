class Product {
  final int? id;
  final String name;
  final double price;
  final String? image;
  final String? description;

  Product({
    this.id,
    required this.name,
    required this.price,
    this.image,
    this.description,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['title'] ?? json['name'] ?? '',
      price: (json['price'] is int)
          ? (json['price'] as int).toDouble()
          : (json['price'] as double),
      image: json['image'],
      description: json['description'],
    );
  }
}
