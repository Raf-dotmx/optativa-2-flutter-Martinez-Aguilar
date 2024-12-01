class ProductSearchDTO {
  final int id;
  final String title;
  final String description;
  final double price;
  final String thumbnail;

  ProductSearchDTO({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.thumbnail,
  });

  factory ProductSearchDTO.fromJson(Map<String, dynamic> json) {
    return ProductSearchDTO(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price']?.toDouble() ?? 0.0,
      thumbnail: json['thumbnail'],
    );
  }
}
