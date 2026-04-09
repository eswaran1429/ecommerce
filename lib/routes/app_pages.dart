import 'package:get/get.dart';
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
    ),
    GetPage(
      name: AppRoutes.productDetail,
      page: () => const ProductDetailPage(),
    ),
    GetPage(
      name: AppRoutes.cart,
      page: () => CartPage(),
    ),
    GetPage(
      name: AppRoutes.wishlist,
      page: () => WishlistPage(),
    ),
  ];
}