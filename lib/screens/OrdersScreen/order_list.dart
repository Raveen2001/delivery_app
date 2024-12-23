import 'package:delivery_app/models/order_model.dart';
import 'package:delivery_app/screens/OrderDetailsScreen/order_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderList extends StatelessWidget {
  const OrderList({
    super.key,
    required this.orders,
  });

  final List<AppOrder> orders;

  @override
  Widget build(BuildContext context) {
    return orders.isEmpty
        ? const Center(
            child: Text("No orders in last 2 days"),
          )
        : ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return ListTile(
                title: Row(
                  children: [
                    Text("Order #${order.billNumber}"),
                    const Spacer(),
                    Text("Rs. ${order.billAmount}",
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.red)),
                  ],
                ),
                subtitle:
                    Text("${order.customerName} (${order.customerAddress})"),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () => Get.to(() => OrderDetailsScreen(order: order)),
              );
            });
  }
}
