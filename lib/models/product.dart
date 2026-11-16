class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final int stock;
  final String? image;
  final int categoryId;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
    this.image,
    required this.categoryId,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] is int ? json['id'] : int.parse(json['id'].toString()),
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] is double
          ? json['price']
          : double.parse((json['price'] ?? 0.0).toString()),
      stock: json['stock'] is int
          ? json['stock']
          : int.parse((json['stock'] ?? 0).toString()),
      image: json['image'] ?? json['image_url'] ?? json['imagen_url'],
      categoryId: json['category_id'] is int
          ? json['category_id']
          : int.parse((json['category_id'] ?? 0).toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'stock': stock,
      'image': image,
      'category_id': categoryId,
    };
  }
}
