import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'cart_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CartPage extends StatelessWidget {
  final controller = Get.put(CartController());

  CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cart")),
      body: Obx(() {
        if (controller.cartItems.isEmpty) {
          return const Center(child: Text("Cart is empty"));
        }

        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: controller.cartItems.length,
                itemBuilder: (_, index) {
                  final item = controller.cartItems[index];

                  return ListTile(
                    leading: CachedNetworkImage(
                      imageUrl: item.product.image,
                      width: 50,
                      placeholder: (context, url) => const SizedBox(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                    title: Text(item.product.title),
                    subtitle: Text("₹${item.totalPrice.toStringAsFixed(2)}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () => controller.decreaseQty(index),
                          icon: const Icon(Icons.remove),
                        ),
                        Text(item.quantity.toString()),
                        IconButton(
                          onPressed: () => controller.increaseQty(index),
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // 💰 Total
            Padding(
              padding: const EdgeInsets.all(16),
              child: Obx(() => Text(
                    "Total: ₹${controller.totalPrice.toStringAsFixed(2)}",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  )),
            ),

            ElevatedButton(
              onPressed: controller.clearCart,
              child: const Text("Clear Cart"),
            ),
          ],
        );
      }),
    );
  }
}
