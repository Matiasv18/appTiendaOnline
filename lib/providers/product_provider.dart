import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/category.dart';
import '../service/api_service.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  List<Category> _categories = [];
  bool _isLoading = false;

  List<Product> get products => _products;
  List<Category> get categories => _categories;
  bool get isLoading => _isLoading;

  final ApiService _apiService = ApiService();

  Future<void> fetchCategories() async {
    try {
      _categories = await _apiService.getCategories();
      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching categories: $e');
    }
  }

  Future<void> fetchProducts({int? categoryId}) async {
    _isLoading = true;
    notifyListeners();
    try {
      _products = await _apiService.getProducts(categoryId: categoryId);
    } catch (e) {
      debugPrint('Error fetching products: $e');
    }
    _isLoading = false;
    notifyListeners();
  }
}