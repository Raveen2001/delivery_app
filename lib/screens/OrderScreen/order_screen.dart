import 'package:delivery_app/services/order_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderScreen extends StatelessWidget {
  OrderScreen({super.key});

  final orderService = Get.find<OrderService>();
  @override
  Widget build(BuildContext context) {
    return Obx(() => orderService.orders.isEmpty
        ? const Center(child: Text("No Orders in last 5 days"))
        : ListView.builder(
            itemCount: orderService.orders.length,
            itemBuilder: (context, index) {
              final order = orderService.orders[index];
              return ListTile(
                title: Text("Order #${order.billNumber}"),
                subtitle: const Text("Order details"),
                trailing: const Icon(Icons.arrow_forward_ios),
              );
            }));
  }
}
