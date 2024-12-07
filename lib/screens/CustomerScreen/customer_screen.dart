import 'package:delivery_app/services/customer_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerScreen extends StatelessWidget {
  CustomerScreen({super.key});

  final customerService = Get.find<CustomerService>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView.builder(
        itemCount: customerService.customers.length,
        itemBuilder: (context, index) {
          final customer = customerService.customers[index];
          return Column(
            children: [
              ListTile(
                title: Text("${customer.name} (+91 ${customer.phone})"),
                subtitle: Text(customer.address),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    customer.googleLocation != null &&
                            customer.googleLocation!.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.location_on_outlined),
                            onPressed: () {},
                          )
                        : Container(),
                    IconButton(
                      icon: const Icon(Icons.edit_outlined),
                      onPressed: () {
                        Get.toNamed("/add-edit-customer", arguments: {
                          "phone": customer.phone,
                          "isEdit": true,
                        });
                      },
                    ),
                  ],
                ),
              ),
              const Divider(),
            ],
          );
        }));
  }
}
