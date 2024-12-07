import 'package:delivery_app/services/order_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class OrderScreen extends StatelessWidget {
  OrderScreen({super.key});

  final orderService = Get.find<OrderService>();
  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView.builder(
        itemCount: orderService.orders.length,
        itemBuilder: (context, index) {
          final order = orderService.orders[index];
          return ListTile(
            title: Text("Order #${order.billNumber}"),
            subtitle: Text("Order details"),
            trailing: const Icon(Icons.arrow_forward_ios),
          );
        }));
  }
}
