import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/cart_item_model.dart';
import '../../models/product_model.dart';
import '../../repositories/cart_repository.dart';

class CartController extends GetxController {
  final CartRepository _repo = CartRepository();

  var cartItems = <CartItemModel>[].obs;
  static const int maxStock = 5;

  @override
  void onInit() {
    super.onInit();
    loadCart();
  }

  void loadCart() {
    cartItems.assignAll(_repo.getCartItems());
  }

 void addToCart(ProductModel product) {
  final index = cartItems.indexWhere(
    (item) => item.product.id == product.id,
  );

  if (index != -1) {
    // ❌ STOCK LIMIT CHECK
    if (cartItems[index].quantity >= maxStock) {
      Get.snackbar(
        "Stock Limit Reached",
        "Only $maxStock items available",
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    cartItems[index].quantity++;
  } else {
    cartItems.add(CartItemModel(product: product));
  }

  cartItems.refresh();
  _repo.addToCart(product);
}
  void removeItem(int index) {
    cartItems.removeAt(index);
    _repo.removeFromCart(index);
  }

  void increaseQty(int index) {
  if (cartItems[index].quantity >= maxStock) {
    Get.snackbar(
      backgroundColor: const Color.fromARGB(255, 156, 156, 156),
      colorText: Colors.white,
      "Limit reached",
      "Maximum $maxStock items allowed",
      snackPosition: SnackPosition.TOP,
    );
    return;
  }
  cartItems.refresh();

  _repo.addToCart(cartItems[index].product);
}

  void decreaseQty(int index) {
    if (cartItems[index].quantity > 1) {
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