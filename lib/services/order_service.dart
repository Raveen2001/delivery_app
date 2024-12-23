import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/models/order_model.dart';
import 'package:get/get.dart';

class OrderService extends GetxService {
  final _firestore = FirebaseFirestore.instance;
  final _ordersCollection = 'orders';

  final _orders = <AppOrder>[].obs;

  List<AppOrder> get orders => _orders;

  List<AppOrder> get pendingOrders =>
      _orders.where((order) => order.status == OrderStatus.pending).toList();

  List<AppOrder> get deliveredOrders =>
      _orders.where((order) => order.status == OrderStatus.delivered).toList();

  List<AppOrder> get cancelledOrders =>
      _orders.where((order) => order.status == OrderStatus.cancelled).toList();

  List<AppOrder> get outForDeliveryOrders => _orders
      .where((order) => order.status == OrderStatus.outForDelivery)
      .toList();

  @override
  void onInit() {
    super.onInit();
    _orders.bindStream(getOrdersStream());
  }

  Stream<List<AppOrder>> getOrdersStream() {
    final twoDaysAgo = DateTime.now().subtract(const Duration(days: 2));
    return _firestore
        .collection(_ordersCollection)
        .where('billDate', isGreaterThanOrEqualTo: twoDaysAgo)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => AppOrder.fromJson(doc.data())).toList());
  }

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
    await _firestore
        .collection(_ordersCollection)
        .doc(order.billNumber.toString())
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
