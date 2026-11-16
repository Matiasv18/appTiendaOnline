import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/constants.dart';
import '../models/category.dart';
import '../models/product.dart';
import '../models/user.dart';

class ApiService {
  final String baseUrl = AppConstants.baseUrl;

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      return Map<String, dynamic>.from(jsonDecode(response.body) as Map);
    } else {
      throw Exception('Error al iniciar sesión');
    }
  }

  Future<void> register(String name, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name, 'email': email, 'password': password}),
    );

    if (response.statusCode != 201 && response.statusCode != 200) {
      throw Exception('Error al registrar usuario');
    }
  }

  Future<User> getUserProfile(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/auth/profile'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return User.fromJson(
        Map<String, dynamic>.from(jsonDecode(response.body) as Map),
      );
    } else {
      throw Exception('No se pudo obtener el perfil');
    }
  }

  Future<List<Category>> getCategories() async {
    final response = await http.get(Uri.parse('$baseUrl/categories'));
    if (response.statusCode == 200) {
      final list = jsonDecode(response.body) as List<dynamic>;
      return list
          .map(
            (model) =>
                Category.fromJson(Map<String, dynamic>.from(model as Map)),
          )
          .toList();
    } else {
      throw Exception('Error al cargar categorías');
    }
  }

  Future<List<Product>> getProducts({int? categoryId}) async {
    final url = categoryId != null
        ? '$baseUrl/products/category/$categoryId'
        : '$baseUrl/products';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final list = jsonDecode(response.body) as List<dynamic>;
      return list
          .map(
            (model) =>
                Product.fromJson(Map<String, dynamic>.from(model as Map)),
          )
          .toList();
    } else {
      throw Exception('Error al cargar productos');
    }
  }
}
