import '../core/hive_service.dart';
import '../models/cart_item_model.dart';
import '../models/product_model.dart';

class CartRepository {
  final box = HiveService.getCartBox();

  List<CartItemModel> getCartItems() {
    return box.values.cast<CartItemModel>().toList();
  }

  void addToCart(ProductModel product) {
    final existingIndex = box.values.toList().indexWhere(
          (item) => item.product.id == product.id,
        );

    if (existingIndex != -1) {
      final item = box.getAt(existingIndex) as CartItemModel;
      item.quantity++;

      box.putAt(existingIndex, item);
    } else {
      box.add(CartItemModel(product: product));
    }
  }

  void removeFromCart(int index) {
    box.deleteAt(index);
  }

  void decreaseQuantity(int index) {
    final item = box.getAt(index) as CartItemModel;

    if (item.quantity > 1) {
      item.quantity--;
      box.putAt(index, item);
    } else {
      box.deleteAt(index);
    }
  }

  double getTotal() {
    return box.values
        .cast<CartItemModel>()
        .fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  void clearCart() {
    box.clear();
  }
}