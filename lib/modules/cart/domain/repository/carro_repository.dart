import 'package:flutter_examen_2/modules/cart/domain/dto/carro_Dto.dart';
import 'package:localstorage/localstorage.dart';

class CartRepository {
  final LocalStorage storage = LocalStorage('cart');

  Future<List<CartItemDTO>> getCartItems() async {
    await storage.ready;
    List<dynamic> items = storage.getItem('cart') ?? [];
    return items.map((item) => CartItemDTO.fromJson(item)).toList();
  }

  Future<void> saveCartItems(List<CartItemDTO> items) async {
    await storage.ready;
    storage.setItem('cart', items.map((item) => item.toJson()).toList());
  }
}
