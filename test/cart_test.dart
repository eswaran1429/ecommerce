import 'package:flutter_test/flutter_test.dart';
import 'package:ecommerce/models/product_model.dart';

import 'testCart_controller.dart';

void main() {
  late TestCartController controller;

  final mockProduct = ProductModel(
    id: 1,
    title: "Test Product",
    price: 100,
    description: "desc",
    category: 'test',
    images: [],
  );

  setUp(() {
    controller = TestCartController();
  });

  // ✅ Add item
  test("Add item to cart", () {
    controller.addToCart(mockProduct);

    expect(controller.cartItems.length, 1);
    expect(controller.cartItems.first.quantity, 1);
  });

  // ✅ Increment
  test("Increment quantity", () {
    controller.addToCart(mockProduct);
    controller.addToCart(mockProduct);

    expect(controller.cartItems.first.quantity, 2);
  });

  // ✅ Decrement
  test("Decrease quantity", () {
    controller.addToCart(mockProduct);
    controller.addToCart(mockProduct);

    controller.decreaseQty(0);

    expect(controller.cartItems.first.quantity, 1);
  });

  // ✅ Remove when quantity = 1
  test("Remove item when quantity is 1", () {
    controller.addToCart(mockProduct);

    controller.decreaseQty(0);

    expect(controller.cartItems.isEmpty, true);
  });

  // ✅ Total calculation
  test("Total price calculation", () {
    controller.addToCart(mockProduct); // 100
    controller.addToCart(mockProduct); // 200

    expect(controller.totalPrice, 200);
  });

  // ✅ Stock limit
  test("Should not exceed max stock", () {
    for (int i = 0; i < TestCartController.maxStock + 2; i++) {
      controller.addToCart(mockProduct);
    }

    expect(
      controller.cartItems.first.quantity,
      TestCartController.maxStock,
    );
  });
}