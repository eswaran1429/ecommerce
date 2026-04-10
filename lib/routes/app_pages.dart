import 'package:ecommerce/bindings/wishlist_binding.dart';
import 'package:get/get.dart';
import '../bindings/cart_binding.dart';
import '../bindings/product_binding.dart';
import '../modules/product/product_page.dart';
import '../modules/product/product_detail_page.dart';
import '../modules/cart/cart_page.dart';
import '../modules/wishlist/wishlist_page.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.home,
      page: () => ProductPage(),
      binding: ProductBinding(),
    ),
    GetPage(
      name: AppRoutes.productDetail,
      page: () => const ProductDetailPage(),
      binding: CartBinding()
    ),
    GetPage(
      name: AppRoutes.cart,
      page: () => CartPage(),
      binding: CartBinding(),
    ),
    GetPage(
      name: AppRoutes.wishlist,
      page: () => WishlistPage(),
      binding: InitialBinding()
    ),
  ];
}