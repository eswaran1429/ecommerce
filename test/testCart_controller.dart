// cart_controller.dart
import 'package:ecommerce/models/cart_item_model.dart';
import 'package:ecommerce/models/product_model.dart';

class TestCartController {
  List<CartItemModel> cartItems = [];

  static const int maxStock = 5;

  void addToCart(ProductModel product) {
    final index =
        cartItems.indexWhere((e) => e.product.id == product.id);

    if (index != -1) {
      if (cartItems[index].quantity >= maxStock) return;

      cartItems[index].quantity++;
    } else {
      cartItems.add(CartItemModel(product: product));
    }
  }

  void decreaseQty(int index) {
    final item = cartItems[index];

    if (item.quantity > 1) {
      item.quantity--;
    } else {
      cartItems.removeAt(index);
    }
  }

  double get totalPrice =>
      cartItems.fold(0, (sum, item) => sum + item.totalPrice);
}