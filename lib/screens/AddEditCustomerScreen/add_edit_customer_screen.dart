import 'package:delivery_app/screens/AddEditCustomerScreen/add_edit_customer_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddEditCustomerScreen extends StatelessWidget {
  static const routeName = '/add-edit-customer';
  AddEditCustomerScreen({super.key});

  final controller = Get.put(AddEditCustomerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('${controller.isEditing ? 'Edit' : 'Add New'} Customer')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: controller.nameTextController,
                  decoration: const InputDecoration(
                      labelText: 'Name', border: OutlineInputBorder()),
                  validator: (value) {
                    if (value == null) {
                      return 'Please enter name';
                    }

                    value = value.trim();
                    if (value.isEmpty) {
                      return 'Please enter name';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: controller.phoneTextController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                      labelText: 'Phone', border: OutlineInputBorder()),
                  validator: (value) {
                    if (value == null) {
                      return 'Please enter phone number';
                    }

                    value = value.trim();
                    if (value.isEmpty) {
                      return 'Please enter phone number';
                    }

                    if (value.length != 10) {
                      return 'Please enter a valid phone number';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: controller.addressTextController,
                  decoration: const InputDecoration(
                      labelText: 'Address', border: OutlineInputBorder()),
                  validator: (value) {
                    if (value == null) {
                      return 'Please enter address';
                    }

                    value = value.trim();
                    if (value.isEmpty) {
                      return 'Please enter address';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: controller.locationTextController,
                  decoration: const InputDecoration(
                      labelText: 'Google Map Location',
                      border: OutlineInputBorder()),
                ),
                const SizedBox(height: 16),
                Obx(
                  () => ElevatedButton(
                    onPressed: controller.onSubmit,
                    child: controller.isLoading.value
                        ? const SizedBox(
                            height: 24, // Custom height
                            width: 24, // Custom width
                            child: CircularProgressIndicator(),
                          )
                        : Text(
                            '${controller.isEditing ? 'Edit' : 'Add'} Customer'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
