import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/models/customer_model.dart';
import 'package:delivery_app/services/order_service.dart';
import 'package:delivery_app/utils/date.dart';
import 'package:delivery_app/utils/files.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:delivery_app/models/order_model.dart';
import 'package:image_picker/image_picker.dart';

class AddEditOrderController extends GetxController {
  final firestore = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;
  final orderService = Get.find<OrderService>();

  final editOrderId = Get.parameters['id'];
  final isEditing = Get.parameters['id'] != null;

  // Controllers for form fields
  final formKey = GlobalKey<FormState>();
  final billAmountController = TextEditingController();
  var billDate = LONG_DATE_FORMAT.format(DateTime.now()); // For date input

  final selectedImages = Rx<List<File>>([]);
  final selectedCustomer = Rx<AppCustomer?>(null);

  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();

    if (isEditing) {
      // Load existing order for editing
      isLoading.value = true;

      orderService.getOrderById(editOrderId!).then((order) {
        initializeFields(order);
      }).whenComplete(() {
        isLoading.value = false;
      });
    }
  }

  // Add/Edit order
  Future<void> onSubmit() async {
    if (isLoading.value) return;
    if (!formKey.currentState!.validate()) return;
    if (selectedCustomer.value == null) {
      Get.snackbar("Error", "Please select a customer");
      return;
    }

    if (selectedImages.value.isEmpty) {
      Get.snackbar("Error", "Please select an image");
      return;
    }

    isLoading.value = true;

    // Get the next bill number
    var billNumber = await orderService.getNextBillNumber();

    // Upload image if new image is selected
    final uploadedImageUrls = await Future.wait(
        selectedImages.value.asMap().entries.map((entry) async {
      final imageFile = entry.value;
      final key = entry.key + 1;
      return await uploadImage(
          imageFile, "orders/$billNumber/bill_images/$key.jpg");
    }).toList());

    final order = AppOrder(
      billImages: uploadedImageUrls,
      billAmount: int.parse(billAmountController.text),
      billNumber: billNumber,
      customerPhone: selectedCustomer.value!.phone,
      billDate: LONG_DATE_FORMAT.parse(billDate),
    );

    if (isEditing) {
      // Update existing order
      await orderService.updateOrder(order);
    } else {
      // Add new order
      await orderService.addOrder(order);
    }

    Get.back(); // Navigate back

    Get.snackbar(
        "Success", "Order #$billNumber ${isEditing ? 'updated' : 'added'}");
  }

  // Pick an image (gallery or camera)
  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFiles = await picker.pickMultiImage();

    if (pickedFiles.isNotEmpty) {
      final files = pickedFiles.map((file) => File(file.path)).toList();
      selectedImages.value = selectedImages.value + files;
    }
  }

  // Initialize fields for editing
  void initializeFields(AppOrder order) {
    billAmountController.text = order.billAmount.toString();
    billDate = order.billDate.toIso8601String();
    // selectedImages.value =  // Clear selected image
  }

  void onImageRemove(int index) {
    selectedImages.value.removeAt(index);

    // Update the UI
    selectedImages.refresh();
  }

  void onCustomerChange(AppCustomer? customer) {
    selectedCustomer.value = customer;
  }
}
