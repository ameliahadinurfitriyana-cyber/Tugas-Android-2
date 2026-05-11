import 'package:flutter/material.dart';
import '../domain/product_model.dart';

class EditPage extends StatefulWidget {
  final Product product;

  const EditPage({super.key, required this.product});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  late final TextEditingController _nameController;
  late final TextEditingController _priceController;
  late final TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.product.name);
    _priceController = TextEditingController(
      text: widget.product.price.toString(),
    );
    _descriptionController = TextEditingController(
      text: widget.product.description ?? '',
    );
  }

  void _saveProduct() {
    final name = _nameController.text.trim();
    final price = double.tryParse(_priceController.text.trim());
    final description = _descriptionController.text.trim();

    if (name.isEmpty || price == null || price <= 0 || description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter valid product data.')),
      );
      return;
    }

    final updatedProduct = Product(
      name: name,
      price: price,
      description: description,
    );
    Navigator.pop(context, updatedProduct);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Product')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _priceController,
              decoration: const InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 24),
            ElevatedButton(onPressed: _saveProduct, child: const Text('Save')),
          ],
        ),
      ),
    );
  }
}
