import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../models/cart_item_model.dart';
import '../models/product_model.dart';

class HiveService {
  static const String productBox = 'products';
  static const String cartBox = 'cart';

  

  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);

    // Register adapters here later
    Hive.registerAdapter(ProductModelAdapter());
    Hive.registerAdapter(CartItemModelAdapter());

    await Hive.openBox(productBox);
    await Hive.openBox(cartBox);
  }

  static Box getProductBox() => Hive.box(productBox);
  static Box getCartBox() => Hive.box(cartBox);
}

