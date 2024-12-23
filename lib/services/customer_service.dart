import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/models/customer_model.dart';
import 'package:get/get.dart';

class CustomerService extends GetxService {
  final _firestore = FirebaseFirestore.instance;
  final _customersCollection = 'customers';

  final _customers = <AppCustomer>[].obs;

  List<AppCustomer> get customers => _customers;

  @override
  void onInit() {
    super.onInit();
    _customers.bindStream(getCustomersStream());
  }

  Stream<List<AppCustomer>> getCustomersStream() {
    return _firestore.collection(_customersCollection).snapshots().map(
        (snapshot) => snapshot.docs
            .map((doc) => AppCustomer.fromJson(doc.data()))
            .toList());
  }

  Future addCustomer(AppCustomer customer) async {
    await _firestore
        .collection(_customersCollection)
        .doc(customer.phone)
        .set(customer.toJson());
  }

  Future updateCustomer(AppCustomer customer) async {
    await _firestore
        .collection(_customersCollection)
        .doc(customer.phone)
        .update(customer.toJson());
  }

  Future deleteCustomer(String phone) async {
    await _firestore.collection(_customersCollection).doc(phone).delete();
  }

  Future<List<AppCustomer>> getCustomers() async {
    final snapshot = await _firestore.collection(_customersCollection).get();
    return snapshot.docs
        .map((doc) => AppCustomer.fromJson(doc.data()))
        .toList();
  }

  Future<AppCustomer> getCustomerByPhone(String phone) async {
    final doc =
        await _firestore.collection(_customersCollection).doc(phone).get();
    return AppCustomer.fromJson(doc.data()!);
  }

  AppCustomer findCustomerByPhone(String phone) {
    return _customers.firstWhere((customer) => customer.phone == phone);
  }
}
