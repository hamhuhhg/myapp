import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:day59/models/products/ProductModel.dart';

class ProductRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<ProductModel>> getDiscountedProducts() async {
    try {
      final snapshot = await _firestore.collection('Products').get();
      print(await _firestore.collection('Products').get());

      return snapshot.docs
          .map((doc) => ProductModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (error) {
      print('Error fetching discounted products: $error');
      return [];
    }
  }

  Future<ProductModel?> getProductById(String id) async {
    try {
      final doc = await _firestore.collection('Products').doc(id).get();
      if (doc.exists) {
        return ProductModel.fromJson(doc.data() as Map<String, dynamic>);
      } else {
        print('Product with ID $id does not exist.');
      }
    } catch (error) {
      print('Error fetching product by ID: $error');
    }
    return null;
  }
}
