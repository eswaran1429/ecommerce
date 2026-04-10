import 'package:get/get.dart';
import '../modules/wishlist/wishlist_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // ✅ Global controller
    Get.lazyPut<WishlistController>(
      () => WishlistController(),
      fenix: true,
    );
  }
}