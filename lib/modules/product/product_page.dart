import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../routes/app_routes.dart';
import '../../utils/utils.dart';
import '../wishlist/wishlist_controller.dart';
import 'product_controller.dart';

class ProductPage extends StatelessWidget {
  ProductPage({super.key});

  final ProductController controller = Get.find<ProductController>();
  final WishlistController wishlistController =
      Get.find<WishlistController>(); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F7FB),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text(
          "Discover",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark),
            onPressed: () => Get.toNamed(AppRoutes.wishlist),
          ),
          IconButton(
            icon: const Icon(Icons.shopping_bag_outlined),
            onPressed: () => Get.toNamed(AppRoutes.cart),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                autofocus: false,
                onChanged: (value) => controller.searchQuery.value = value,
                decoration: const InputDecoration(
                  hintText: "Search products...",
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  itemCount: 6,
                  itemBuilder: (_, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Row(
                        children: const [
                          AppShimmer(width: 90, height: 90, radius: 16),
                          SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppShimmer(
                                  width: double.infinity,
                                  height: 14,
                                  radius: 8,
                                ),
                                SizedBox(height: 10),
                                AppShimmer(
                                  width: 120,
                                  height: 12,
                                  radius: 8,
                                ),
                                SizedBox(height: 12),
                                AppShimmer(
                                  width: 80,
                                  height: 18,
                                  radius: 8,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  itemCount: controller.filteredProducts.length + 1,
                  itemBuilder: (_, index) {
                    if (index < controller.filteredProducts.length) {
                      final product = controller.filteredProducts[index];

                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.productDetail,
                              arguments: product);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.06),
                                blurRadius: 12,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 90,
                                height: 90,
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: const Color(0xffF2F4F8),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: CachedNetworkImage(
                                    imageUrl: product.image,
                                    fit: BoxFit.contain,
                                    placeholder: (context, url) =>
                                        const AppShimmer(
                                      width: 90,
                                      height: 90,
                                      radius: 12,
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.broken_image_outlined),
                                  ),
                                ),
                              ),

                              const SizedBox(width: 14),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.title,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 8),
                                    Text("\₹${product.price}"),
                                  ],
                                ),
                              ),

                              Obx(() {
                                final isWishlisted = wishlistController.wishlist
                                    .any((p) => p.id == product.id);

                                return IconButton(
                                  icon: Icon(
                                    isWishlisted
                                        ? Icons.bookmark
                                        : Icons.bookmark_border_rounded,
                                    color: isWishlisted
                                        ? Colors.deepPurple
                                        : Colors.grey,
                                  ),
                                  onPressed: () => wishlistController
                                      .toggleWishlist(product),
                                );
                              }),
                            ],
                          ),
                        ),
                      );
                    }

                    return Obx(() {
                      return controller.isLoadingMore.value
                          ? const Padding(
                              padding: EdgeInsets.all(16),
                              child: Center(child: CircularProgressIndicator()),
                            )
                          : const SizedBox();
                    });
                  });
            }),
          ),
        ],
      ),
    );
  }
}
