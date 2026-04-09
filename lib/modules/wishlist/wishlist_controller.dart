import 'package:get/get.dart';
import '../../models/product_model.dart';
import '../../core/hive_service.dart';

class WishlistController extends GetxController {
  var wishlist = <ProductModel>[].obs;

final box = HiveService.getProductBox(); // reuse or create new box

@override
void onInit() {
  super.onInit();
  wishlist.assignAll(box.values.cast<ProductModel>().toList());
}

void toggleWishlist(ProductModel product) {
  final exists = isInWishlist(product);

  if (exists) {
    wishlist.removeWhere((p) => p.id == product.id);
    box.delete(product.id);
  } else {
    wishlist.add(product);
    box.put(product.id, product);
  }
}
  bool isInWishlist(ProductModel product) {
    return wishlist.any((p) => p.id == product.id);
  }
}