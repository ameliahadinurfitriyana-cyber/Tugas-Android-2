import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'product_provider.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () =>
          Provider.of<ProductProvider>(context, listen: false).fetchProducts(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("API Products")),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : provider.error != null
          ? Center(child: Text(provider.error!))
          : ListView.builder(
              itemCount: provider.products.length,
              itemBuilder: (context, index) {
                final product = provider.products[index];
                return ListTile(
                  leading: product.image != null
                      ? Image.network(product.image!, width: 50)
                      : const SizedBox(width: 50),
                  title: Text(product.name),
                  subtitle: Text("Rp ${product.price}"),
                );
              },
            ),
    );
  }
}
