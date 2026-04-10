import 'package:get/get.dart';
import '../../models/product_model.dart';
import '../../core/hive_service.dart';

class WishlistController extends GetxController {
  var wishlist = <ProductModel>[].obs;

  final box = HiveService.getWishlistBox();
  

  @override
  void onInit() {
    super.onInit();
    loadWishlist();
  }

  void loadWishlist() {
    wishlist.assignAll(box.values.toList());
  }

  void toggleWishlist(ProductModel product) {
    final key = product.id.toString();

    if (box.containsKey(key)) {
      box.delete(key);
      wishlist.removeWhere((p) => p.id == product.id);
    } else {
      box.put(key, product);
      wishlist.add(product);
    }
  }

  bool isInWishlist(ProductModel product) {
    return box.containsKey(product.id.toString());
  }
}