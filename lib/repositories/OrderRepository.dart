import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:day59/models/order/OrderModel.dart';
import 'package:day59/models/user/UserModel.dart';
import 'package:day59/models/cart/CartModel.dart';
import 'package:day59/models/products/ProductModel.dart';

class OrderRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  Future<List<OrderModel>> getOrderHistory(String userId) async {
    final snapshot = await _firestore
        .collection('orders')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .get();
    return snapshot.docs
        .map((doc) => OrderModel.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }
  
  Future<void> createOrder(OrderModel order) async {
    await _firestore
        .collection('orders')
        .doc(order.id)  // أو استخدم auto-generated id
        .set(order.toMap());
  }
}
