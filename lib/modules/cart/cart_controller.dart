import 'package:get/get.dart';
import '../../models/cart_item_model.dart';
import '../../models/product_model.dart';
import '../../repositories/cart_repository.dart';

class CartController extends GetxController {
  final CartRepository _repo = CartRepository();

  var cartItems = <CartItemModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadCart();
  }

  void loadCart() {
    cartItems.assignAll(_repo.getCartItems());
  }

  // 🟢 Add to cart (Optimistic UI)
  void addToCart(ProductModel product) {
    final index = cartItems.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (index != -1) {
      cartItems[index].quantity++;
    } else {
      cartItems.add(CartItemModel(product: product));
    }

    cartItems.refresh(); // 🔥 update UI instantly
    _repo.addToCart(product); // persist
  }

  void removeItem(int index) {
    cartItems.removeAt(index);
    _repo.removeFromCart(index);
  }

  void increaseQty(int index) {
    cartItems[index].quantity++;
    cartItems.refresh();
    _repo.addToCart(cartItems[index].product);
  }

  void decreaseQty(int index) {
    if (cartItems[index].quantity > 1) {
      cartItems[index].quantity--;
      cartItems.refresh();
      _repo.decreaseQuantity(index);
    } else {
      removeItem(index);
    }
  }

  double get totalPrice {
    return cartItems.fold(
      0.0,
      (sum, item) => sum + item.totalPrice,
    );
  }

  void clearCart() {
    cartItems.clear();
    _repo.clearCart();
  }
}