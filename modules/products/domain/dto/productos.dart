class Product {
  final int id;
  final String title;
  final String thumbnail;
  final String description;
  final String category;
  final double price;
  final List<String> images;

  Product({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.description,
    required this.category,
    required this.price,
    required this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      thumbnail: json['thumbnail'],
      description: json['description'],
      category: json['category'],
      price: json['price'],
      images: List<String>.from(json['images']),
    );
  }
}
