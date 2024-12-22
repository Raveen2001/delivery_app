import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/models/customer_model.dart';
import 'package:delivery_app/services/customer_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddEditCustomerController extends GetxController {
  final firestore = FirebaseFirestore.instance;
  final customerService = Get.find<CustomerService>();

  final inputCustomerPhone = Get.arguments['phone'];
  final isEditing = (Get.arguments['isEdit'] ?? false) as bool;

  // Controllers for form fields
  final formKey = GlobalKey<FormState>();
  final nameTextController = TextEditingController();
  final addressTextController = TextEditingController();
  final locationTextController = TextEditingController();
  final phoneTextController = TextEditingController();

  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();

    if (inputCustomerPhone != null) {
      // Load existing order for editing
      phoneTextController.text = inputCustomerPhone!;
    }

    if (isEditing) {
      // Load existing order for editing
      isLoading.value = true;

      customerService.getCustomerByPhone(inputCustomerPhone!).then((customer) {
        initializeFields(customer);
      }).whenComplete(() {
        isLoading.value = false;
      });
    }
  }

  // Add/Edit order
  Future<void> onSubmit() async {
    if (isLoading.value) return;
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;

    final customer = AppCustomer(
      name: nameTextController.text,
      address: addressTextController.text,
      googleLocation: locationTextController.text,
      phone: phoneTextController.text,
      createdAt: DateTime.now(),
    );

    if (isEditing) {
      // Update existing order
      await customerService.updateCustomer(customer);
    } else {
      // Add new order
      await customerService.addCustomer(customer);
    }

    Get.back(result: customer); // Navigate back

    Get.snackbar("Success",
        "Customer ${nameTextController.text} ${isEditing ? 'updated' : 'added'}");
  }

  // Initialize fields for editing
  void initializeFields(AppCustomer customer) {
    nameTextController.text = customer.name;
    addressTextController.text = customer.address;
    locationTextController.text = customer.googleLocation ?? '';
    phoneTextController.text = customer.phone;
  }
}
