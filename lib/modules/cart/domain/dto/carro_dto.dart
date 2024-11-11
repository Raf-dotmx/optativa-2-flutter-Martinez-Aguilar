class CartItemDTO {
  final int id;
  final String name;
  final String thumbnail;
  final double price;
  final int quantity;
  final double total;

  CartItemDTO({
    required this.id,
    required this.name,
    required this.thumbnail,
    required this.price,
    required this.quantity,
    required this.total,
  });

  factory CartItemDTO.fromJson(Map<String, dynamic> json) {
    return CartItemDTO(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Unknown',
      thumbnail: json['thumbnail'] ?? 'https://via.placeholder.com/60',
      price: json['price'].toDouble(),
      quantity: json['quantity'],
      total: json['total'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'thumbnail': thumbnail,
      'price': price,
      'quantity': quantity,
      'total': total,
    };
  }
}
