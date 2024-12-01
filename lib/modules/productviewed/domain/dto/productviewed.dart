class ProductViewed {
  final int productId;
  final String name;
  final double price;
  int views;

  ProductViewed({
    required this.productId,
    required this.name,
    required this.price,
    required this.views,
  });

  factory ProductViewed.fromJson(Map<String, dynamic> json) {
    return ProductViewed(
      productId: json['productId'],
      name: json['name'],
      price: json['price'],
      views: json['views'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'name': name,
      'price': price,
      'views': views,
    };
  }
}
