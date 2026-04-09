import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/product_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../cart/cart_controller.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductModel product = Get.arguments;
    final cartController = Get.find<CartController>();

    return Scaffold(
      appBar: AppBar(title: Text(product.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: product.image,
              height: 200,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            const SizedBox(height: 16),
            Text(product.title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text("\$${product.price}"),
            const SizedBox(height: 16),
            Text(product.description),
            ElevatedButton(
              onPressed: () {
                cartController.addToCart(product);
                Get.snackbar("Success", "Added to cart");
              },
              child: const Text("Add to Cart"),
            )
          ],
        ),
      ),
    );
  }
}
