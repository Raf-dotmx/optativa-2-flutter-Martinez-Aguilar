import 'package:flutter_examen_2/modules/cart/domain/dto/carro_Dto.dart';
import 'package:flutter_examen_2/modules/cart/domain/repository/carro_repository.dart';

class CartUseCase {
  final CartRepository _repository;

  CartUseCase(this._repository);

  Future<List<CartItemDTO>> loadCartItems() async {
    return await _repository.getCartItems();
  }

  double calculateTotalAmount(List<CartItemDTO> cartItems) {
    return cartItems.fold(0, (sum, item) => sum + item.total);
  }

  Future<List<CartItemDTO>> removeItem(List<CartItemDTO> cartItems, int index) async {
    cartItems.removeAt(index);  
    await _repository.saveCartItems(cartItems); 
    return cartItems;  
  }
}
