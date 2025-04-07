import 'package:day59/controllers/products/ProductController.dart';
import 'package:day59/providers/ProductProvider.dart';
import 'package:day59/repositories/ProductRepository.dart';
import 'package:get/get.dart';

class ProductBinding implements Bindings {
  @override
  void dependencies() {
    // إنشاء ProductRepository بدون أي وسائط
    Get.lazyPut<ProductRepository>(() => ProductRepository());

    // إنشاء ProductProvider مع تمرير ProductRepository كوسيط
    Get.lazyPut<ProductProvider>(() => ProductProvider(Get.find<ProductRepository>()));

    // إنشاء ProductController مع تمرير ProductRepository كوسيط
    Get.lazyPut<ProductController>(() => ProductController(Get.find<ProductRepository>()));
  }
}
