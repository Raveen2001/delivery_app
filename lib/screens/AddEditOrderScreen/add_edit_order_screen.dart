import 'package:delivery_app/screens/AddEditOrderScreen/add_edit_order_controller.dart';
import 'package:delivery_app/widgets/file_carousel_slider.dart';
import 'package:delivery_app/widgets/network_carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddEditOrderScreen extends StatelessWidget {
  static const String routeName = "/add-edit-order";
  AddEditOrderScreen({super.key});

  final controller = Get.put(AddEditOrderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(controller.isEditing ? "Edit Order" : "Add Order")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              Text(
                "Order Date: ${controller.billDate}",
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.right,
              ),
              const SizedBox(height: 36),
              TextFormField(
                  controller: controller.billAmountController,
                  decoration: const InputDecoration(
                      labelText: "Bill Amount",
                      border: OutlineInputBorder(),
                      prefix: Icon(Icons.currency_rupee_sharp, size: 16)),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter bill amount";
                    }
                    if (!value.isNumericOnly) {
                      return "Please enter a valid number";
                    }
                  }),
              const SizedBox(height: 16),
              TextFormField(
                controller: controller.customerIdController,
                decoration: const InputDecoration(labelText: "Customer ID"),
                validator: (value) =>
                    value!.isEmpty ? "Please enter customer ID" : null,
              ),
              const SizedBox(height: 26),
              Obx(() => controller.selectedImages.value.isEmpty
                  ? const Text("No image selected")
                  : FileCarouselSlider(
                      imgList: controller.selectedImages.value,
                      onImageRemove: controller.onImageRemove,
                    )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.camera_alt),
                    onPressed: () => controller.pickImage(ImageSource.camera),
                  ),
                  IconButton(
                    icon: const Icon(Icons.photo),
                    onPressed: () => controller.pickImage(ImageSource.gallery),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Obx(() => ElevatedButton(
                    onPressed: controller.onSubmit,
                    child: controller.isLoading.value
                        ? const SizedBox(
                            height: 24, // Custom height
                            width: 24, // Custom width
                            child: CircularProgressIndicator(),
                          )
                        : Text(controller.isEditing
                            ? "Update Order"
                            : "Add Order"),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
