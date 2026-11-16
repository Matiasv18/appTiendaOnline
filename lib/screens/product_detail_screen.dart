import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: product.image != null
                        ? Image.network(product.image!, height: 200, fit: BoxFit.cover)
                        : const Icon(Icons.image, size: 150),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    product.name,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 20, color: Colors.green, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text('Stock disponible: ${product.stock}'),
                  const SizedBox(height: 20),
                  const Text('Descripción:', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  Text(product.description),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
              icon: const Icon(Icons.add_shopping_cart),
              label: const Text('Agregar al Carrito'),
              onPressed: () {
                cartProvider.addItem(product);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Producto agregado al carrito')),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}