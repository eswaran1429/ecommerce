import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_routes.dart';
import '../wishlist/wishlist_controller.dart';
import 'product_controller.dart';

class ProductPage extends StatelessWidget {
  final controller = Get.put(ProductController());
  final wishlistController = Get.find<WishlistController>();

  ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () => Get.toNamed(AppRoutes.wishlist),
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => Get.toNamed(AppRoutes.cart),
          ),
        ],
      ),
      body: Column(
        children: [
          // 🔍 Search
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              onChanged: (value) => controller.searchQuery.value = value,
              decoration: const InputDecoration(
                hintText: "Search products...",
                border: OutlineInputBorder(),
              ),
            ),
          ),

          // 📦 List
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.hasError.value) {
                return Center(
                  child: ElevatedButton(
                    onPressed: controller.retry,
                    child: const Text("Retry"),
                  ),
                );
              }

              return ListView.builder(
                key: const PageStorageKey("productList"),
                controller: controller.scrollController,
                itemCount: controller.filteredProducts.length,
                itemBuilder: (_, index) {
                  final product = controller.filteredProducts[index];

                  return ListTile(
                    leading: Image.network(product.image, width: 50),
                    title: Text(product.title),
                    subtitle: Text("\$${product.price}"),
                    onTap: () {
                      Get.toNamed('/product-detail', arguments: product);
                    },
                    trailing: IconButton(
                      icon: Obx(() => Icon(
                            wishlistController.isInWishlist(product)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Colors.red,
                          )),
                      onPressed: () =>
                          wishlistController.toggleWishlist(product),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
