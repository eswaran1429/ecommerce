import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/product_model.dart';
import '../../repositories/product_repository.dart';

class ProductController extends GetxController {
  final ProductRepository _repo = ProductRepository();

  var products = <ProductModel>[].obs;
  var filteredProducts = <ProductModel>[].obs;

  var isLoading = false.obs;
  var hasError = false.obs;

  var searchQuery = ''.obs;

  final scrollController = ScrollController();

  int page = 1;
  final int limit = 10;

  @override
  void onInit() {
    super.onInit();

    fetchProducts();

    // 🔥 Debounce search
    debounce(searchQuery, (_) => applySearch(),
        time: const Duration(milliseconds: 500));

    // 🔥 Infinite scroll
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200) {
        loadMore();
      }
    });
  }

  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;
      hasError.value = false;

      final data = await _repo.fetchProducts();

      products.assignAll(data);
      filteredProducts.assignAll(data);
    } catch (e) {
      hasError.value = true;
    } finally {
      isLoading.value = false;
    }
  }

  void applySearch() {
    if (searchQuery.value.isEmpty) {
      filteredProducts.assignAll(products);
    } else {
      filteredProducts.assignAll(
        products
            .where((p) => p.title
                .toLowerCase()
                .contains(searchQuery.value.toLowerCase()))
            .toList(),
      );
    }
  }

  void loadMore() {
    // FakeStoreAPI doesn’t support pagination
    // so we simulate it (important interview trick)

    if (products.isEmpty) return;

    final moreItems = List<ProductModel>.from(products);
    filteredProducts.addAll(moreItems);
  }

  void retry() {
    fetchProducts();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}