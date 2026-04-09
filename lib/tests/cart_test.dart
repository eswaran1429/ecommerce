import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import '../models/product_model.dart';
import '../modules/cart/cart_controller.dart';


void main() {
  late CartController controller;

  setUp(() {
    controller = CartController();
    Get.put(controller);
  });

  ProductModel mockProduct(int id, double price) {
    return ProductModel(
      id: id,
      title: "Test Product $id",
      price: price,
      description: "desc",
      category: "test",
      images: [],
    );
  }

  test("Add to cart increases item count", () {
    final product = mockProduct(1, 100);

    controller.addToCart(product);

    expect(controller.cartItems.length, 1);
    expect(controller.cartItems.first.quantity, 1);
  });

  test("Adding same product increases quantity", () {
    final product = mockProduct(1, 100);

    controller.addToCart(product);
    controller.addToCart(product);

    expect(controller.cartItems.length, 1);
    expect(controller.cartItems.first.quantity, 2);
  });

  test("Decrease quantity reduces count", () {
    final product = mockProduct(1, 100);

    controller.addToCart(product);
    controller.addToCart(product);

    controller.decreaseQty(0);

    expect(controller.cartItems.first.quantity, 1);
  });

  test("Decrease quantity removes item when reaches zero", () {
    final product = mockProduct(1, 100);

    controller.addToCart(product);

    controller.decreaseQty(0);

    expect(controller.cartItems.isEmpty, true);
  });

  test("Total price calculation is correct", () {
    final product1 = mockProduct(1, 100);
    final product2 = mockProduct(2, 50);

    controller.addToCart(product1); // 100
    controller.addToCart(product2); // 50
    controller.addToCart(product2); // 50

    expect(controller.totalPrice, 200);
  });

  test("Remove item deletes from cart", () {
    final product = mockProduct(1, 100);

    controller.addToCart(product);

    controller.removeItem(0);

    expect(controller.cartItems.isEmpty, true);
  });

  test("Clear cart empties everything", () {
    final product = mockProduct(1, 100);

    controller.addToCart(product);
    controller.clearCart();

    expect(controller.cartItems.isEmpty, true);
  });
}