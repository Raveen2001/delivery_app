import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/models/order_model.dart';
import 'package:get/get.dart';

class OrderService extends GetxService {
  final _firestore = FirebaseFirestore.instance;
  final _ordersCollection = 'orders';

  // Get the next bill number (with concurrency-safe transaction)
  Future<int> getNextBillNumber() async {
    return _firestore.runTransaction((transaction) async {
      final docRef = _firestore.collection('metadata').doc('bill_counter');
      final snapshot = await transaction.get(docRef);

      int currentCounter = snapshot.exists ? snapshot['counter'] : 0;
      transaction.update(docRef, {'counter': currentCounter + 1});

      return (currentCounter + 1);
    });
  }

  Future addOrder(AppOrder order) async {
    final billNumber = await getNextBillNumber();
    await _firestore
        .collection(_ordersCollection)
        .doc(billNumber.toString())
        .set(order.toJson());
  }

  Future updateOrder(AppOrder order) async {
    await _firestore
        .collection(_ordersCollection)
        .doc(order.billNumber.toString())
        .update(order.toJson());
  }

  Future deleteOrder(String billNumber) async {
    await _firestore.collection(_ordersCollection).doc(billNumber).delete();
  }

  Future<List<AppOrder>> getOrders() async {
    final snapshot = await _firestore.collection(_ordersCollection).get();
    return snapshot.docs.map((doc) => AppOrder.fromJson(doc.data())).toList();
  }

  Future<AppOrder> getOrderById(String billNumber) async {
    final doc =
        await _firestore.collection(_ordersCollection).doc(billNumber).get();
    return AppOrder.fromJson(doc.data()!);
  }
}
