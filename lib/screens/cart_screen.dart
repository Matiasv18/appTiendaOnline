import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Carrito de Compras')),
      body: Column(
        children: [
          Expanded(
            child: cartProvider.items.isEmpty
                ? const Center(child: Text('El carrito está vacío'))
                : ListView.builder(
                    itemCount: cartProvider.items.length,
                    itemBuilder: (ctx, i) {
                      final item = cartProvider.items[i];
                      return ListTile(
                        leading: item.product.image != null
                            ? Image.network(item.product.image!, width: 50, fit: BoxFit.cover)
                            : const Icon(Icons.shopping_bag),
                        title: Text(item.product.name),
                        subtitle: Text('Precio: \$${item.product.price} x ${item.quantity}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () {
                                cartProvider.updateQuantity(item.product.id, item.quantity - 1);
                              },
                            ),
                            Text('${item.quantity}'),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                cartProvider.updateQuantity(item.product.id, item.quantity + 1);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                cartProvider.removeItem(item.product.id);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text('\$${cartProvider.totalAmount.toStringAsFixed(2)}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
                  onPressed: cartProvider.items.isEmpty
                      ? null
                      : () {
                          cartProvider.clearCart();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('¡Compra realizada con éxito!')),
                          );
                          Navigator.pop(context);
                        },
                  child: const Text('Finalizar Compra'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}