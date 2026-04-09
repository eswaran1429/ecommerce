import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../product/product_detail_page.dart';
import 'wishlist_controller.dart';

class WishlistPage extends StatelessWidget {
  final controller = Get.put(WishlistController());

  WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Wishlist")),
      body: Obx(() {
        if (controller.wishlist.isEmpty) {
          return const Center(child: Text("No items in wishlist"));
        }

        return ListView.builder(
          itemCount: controller.wishlist.length,
          itemBuilder: (_, index) {
            final product = controller.wishlist[index];

            return ListTile(
              leading: Image.network(product.image, width: 50),
              title: Text(product.title),
              subtitle: Text("₹${product.price}"),
              trailing: IconButton(
                icon: const Icon(Icons.favorite, color: Colors.red),
                onPressed: () => controller.toggleWishlist(product),
              ),
              onTap: () {
                Get.to(() => const ProductDetailPage(),
                    arguments: product);
              },
            );
          },
        );
      }),
    );
  }
}