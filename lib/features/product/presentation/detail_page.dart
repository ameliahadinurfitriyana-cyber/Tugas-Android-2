import 'package:flutter/material.dart';
import '../../../core/routes/app_routes.dart';
import '../domain/product_model.dart';

class DetailPage extends StatefulWidget {
  final Product product;
  final int index;

  const DetailPage({super.key, required this.product, required this.index});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Product _currentProduct;

  @override
  void initState() {
    super.initState();
    _currentProduct = widget.product;
  }

  Future<void> _editProduct() async {
    final updatedProduct = await Navigator.pushNamed(
      context,
      AppRoutes.edit,
      arguments: _currentProduct,
    );
    if (updatedProduct is Product) {
      setState(() {
        _currentProduct = updatedProduct;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          Navigator.pop(context, _currentProduct);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(_currentProduct.name),
          actions: [
            IconButton(icon: const Icon(Icons.edit), onPressed: _editProduct),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_currentProduct.name, style: const TextStyle(fontSize: 24)),
              const SizedBox(height: 10),
              Text('Harga: Rp ${_currentProduct.price}'),
              const SizedBox(height: 10),
              Text(_currentProduct.description ?? 'No description'),
            ],
          ),
        ),
      ),
    );
  }
}
