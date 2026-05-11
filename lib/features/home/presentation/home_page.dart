import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/routes/app_routes.dart';
import '../../product/domain/product_model.dart';
import '../../../providers/product_list_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  void _addProduct() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String name = '';
        String price = '';
        String description = '';

        return AlertDialog(
          title: const Text('Add Product'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Name'),
                onChanged: (value) => name = value,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                onChanged: (value) => price = value,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Description'),
                onChanged: (value) => description = value,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (name.isNotEmpty &&
                    price.isNotEmpty &&
                    description.isNotEmpty) {
                  final product = Product(
                    name: name,
                    price: double.tryParse(price) ?? 0.0,
                    description: description,
                  );
                  ref.read(productListProvider.notifier).addProduct(product);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Riverpod Home")),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ListTile(
            title: Text(product.name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Rp ${product.price}"),
                Text(product.description ?? 'No description'),
              ],
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () async {
              final updatedProduct = await Navigator.pushNamed(
                context,
                AppRoutes.detail,
                arguments: {'product': product, 'index': index},
              );

              if (!mounted) {
                return;
              }

              if (updatedProduct is Product) {
                ref
                    .read(productListProvider.notifier)
                    .updateProduct(index, updatedProduct);
              }
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addProduct,
        child: const Icon(Icons.add),
      ),
    );
  }
}
