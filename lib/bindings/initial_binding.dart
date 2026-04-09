import 'package:get/get.dart';
import '../modules/cart/cart_controller.dart';
import '../modules/wishlist/wishlist_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CartController(), permanent: true);
    Get.put(WishlistController(), permanent: true);
  }
}