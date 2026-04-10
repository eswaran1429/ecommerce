import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/product_model.dart';
import '../../repositories/product_repository.dart';

class ProductController extends GetxController {
  final ProductRepository _repo = ProductRepository();

  var products = <ProductModel>[].obs;
  var filteredProducts = <ProductModel>[].obs;

  var isLoading = false.obs;
  var isLoadingMore = false.obs;
  var hasError = false.obs;

  var searchQuery = ''.obs;

  final scrollController = ScrollController();

  int offset = 0;
  final int limit = 10;
  bool hasMore = true;

  @override
  void onInit() {
    super.onInit();

    fetchProducts();

    // 🔥 debounce search
    debounce(searchQuery, (_) => applySearch(),
        time: const Duration(milliseconds: 500));

    // 🔥 infinite scroll
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200) {
        loadMore();
      }
    });
  }

  // ✅ FIRST LOAD
  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;
      hasError.value = false;

      offset = 0;
      hasMore = true;

      final data = await _repo.fetchProducts(
        offset: offset,
        limit: limit,
      );

      products.assignAll(data);
      filteredProducts.assignAll(data);

      offset += limit;
    } catch (e) {
      hasError.value = true;
    } finally {
      isLoading.value = false;
    }
  }

  // ✅ LOAD MORE (REAL PAGINATION)
  Future<void> loadMore() async {
    if (isLoadingMore.value || !hasMore) return;

    try {
      isLoadingMore.value = true;

      final newData = await _repo.fetchProducts(
        offset: offset,
        limit: limit,
      );

      if (newData.isEmpty) {
        hasMore = false;
        return;
      }

      // ✅ avoid duplicates
      final unique = newData.where(
        (p) => !products.any((e) => e.id == p.id),
      );

      products.addAll(unique);

      offset += limit;

      applySearch(); // 🔥 reapply search after new data
    } catch (e) {
      hasError.value = true;
    } finally {
      isLoadingMore.value = false;
    }
  }

  // ✅ SEARCH
  void applySearch() {
    if (searchQuery.value.isEmpty) {
      filteredProducts.assignAll(products);
    } else {
      filteredProducts.assignAll(
        products.where((p) {
          return p.title
              .toLowerCase()
              .contains(searchQuery.value.toLowerCase());
        }).toList(),
      );
    }
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