import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/category.dart';
import '../providers/product_provider.dart';

class CategoryChip extends StatelessWidget {
  final Category category;

  const CategoryChip({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
      child: ActionChip(
        label: Text(category.name),
        onPressed: () {
          Provider.of<ProductProvider>(context, listen: false)
              .fetchProducts(categoryId: category.id);
        },
      ),
    );
  }
}